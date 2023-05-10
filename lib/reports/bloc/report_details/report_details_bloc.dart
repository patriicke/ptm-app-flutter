import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meetings/reports/models/comments.dart';
import 'package:meetings/reports/models/feedback_rating.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

part 'report_details_event.dart';
part 'report_details_state.dart';

class ReportDetailsBloc extends Bloc<ReportDetailsEvent, ReportDetailsState> {
  ReportDetailsBloc({
    @required String reportId,
    @required AuthenticationRepository authenticationRepository,
  })  : assert(reportId?.isNotEmpty == true),
        assert(authenticationRepository != null),
        _reportId = reportId,
        _authenticationRepository = authenticationRepository,
        super(ReportDetailsLoadInProgress());

  final String _reportId;
  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<ReportDetailsState> mapEventToState(
    ReportDetailsEvent event,
  ) async* {
    if (event is ReportDetailsLoaded) {
      yield* _mapReportDetailsLoadedToState();
    } else if (event is ParentRatingUpdated) {
      yield _mapParentRatingUpdatedToState(event, state);
    } else if (event is ParentCommentsUpdated) {
      yield _mapParentCommentsUpdatedToState(event, state);
    } else if (event is ParentFeedbackSubmitted) {
      yield* _mapParentFeedbackSubmittedToState(event, state);
    }
  }

  Stream<ReportDetailsState> _mapReportDetailsLoadedToState() async* {
    yield ReportDetailsLoadInProgress();
    try {
      var reportApi = ReportApi();
      var authKey = _authenticationRepository.authKey;
      var response = await reportApi.getReportDetail(authKey, _reportId);

      if (response.apiResponseMessage.code != 200) {
        log('Exception when calling ReportApi->getReportDetail. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
        throw Exception(
            'Exception when calling ReportApi->getReportDetail. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
      }
      yield ReportDetailsLoadSuccess(
        reportDetails: response.data,
      );
    } catch (e) {
      yield ReportDetailsLoadFailure(e.toString());
    }
  }

  ReportDetailsState _mapParentRatingUpdatedToState(
      ParentRatingUpdated event, ReportDetailsState state) {
    if (state is ReportDetailsLoadSuccess) {
      final feedbackRating = FeedbackRating.dirty(event.parentRating);

      return state.copyWith(
        feedbackRating: feedbackRating,
        feedbackFormStatus: Formz.validate([
          feedbackRating,
          state.parentComments,
        ]),
      );
    } else
      return state;
  }

  ReportDetailsState _mapParentCommentsUpdatedToState(
      ParentCommentsUpdated event, ReportDetailsState state) {
    if (state is ReportDetailsLoadSuccess) {
      final parentComments = Comments.dirty(event.parentComments);

      return state.copyWith(
        parentComments: parentComments,
        feedbackFormStatus: Formz.validate([
          state.feedbackRating,
          parentComments,
        ]),
      );
    } else
      return state;
  }

  Stream<ReportDetailsState> _mapParentFeedbackSubmittedToState(
      ParentFeedbackSubmitted event, ReportDetailsState state) async* {
    if (state is ReportDetailsLoadSuccess) {
      if (state.feedbackFormStatus.isValidated) {
        yield state.copyWith(
            feedbackFormStatus: FormzStatus.submissionInProgress);
        try {
          var reportApi = ReportApi();
          var authKey = _authenticationRepository.authKey;
          var parentUserId = _authenticationRepository.currentUser.id;
          var vm = ReportParentCommentVm()
            ..parentUserId = parentUserId
            ..comment = state.parentComments.value
            ..rating = state.feedbackRating.value;
          var response =
              await reportApi.rateReport(authKey, _reportId, body: vm);

          if (response.apiResponseMessage.code != 200) {
            log('Exception when calling ReportApi->getReportDetail. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
            throw Exception(
                'Exception when calling ReportApi->getReportDetail. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
          }
          yield state.copyWith(
            feedbackFormStatus: FormzStatus.submissionSuccess,
            feedbackRating: const FeedbackRating.pure(),
            parentComments: const Comments.pure(),
            formError: null,
          );
        } catch (e) {
          yield state.copyWith(
            feedbackFormStatus: FormzStatus.submissionFailure,
            formError: e.toString(),
          );
        }
      }
    } else
      yield state;
  }
}
