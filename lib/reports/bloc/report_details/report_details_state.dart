part of 'report_details_bloc.dart';

abstract class ReportDetailsState extends Equatable {
  const ReportDetailsState();

  @override
  List<Object> get props => [];
}

class ReportDetailsLoadInProgress extends ReportDetailsState {}

class ReportDetailsLoadSuccess extends ReportDetailsState {
  final ReportDetail reportDetails;
  final FormzStatus feedbackFormStatus;
  final FeedbackRating feedbackRating;
  final Comments parentComments;
  final String formError;

  ReportDetailsLoadSuccess({
    this.reportDetails,
    this.feedbackFormStatus = FormzStatus.pure,
    this.feedbackRating = const FeedbackRating.pure(),
    this.parentComments = const Comments.pure(),
    this.formError,
  });

  ReportDetailsLoadSuccess copyWith({
    ReportDetail reportDetails,
    FormzStatus feedbackFormStatus,
    FeedbackRating feedbackRating,
    Comments parentComments,
    String formError,
  }) {
    return ReportDetailsLoadSuccess(
      reportDetails: reportDetails ?? this.reportDetails,
      feedbackFormStatus: feedbackFormStatus ?? this.feedbackFormStatus,
      feedbackRating: feedbackRating ?? this.feedbackRating,
      parentComments: parentComments ?? this.parentComments,
      formError: formError ?? this.formError,
    );
  }

  @override
  List<Object> get props => [
        reportDetails,
        feedbackFormStatus,
        feedbackRating,
        parentComments,
        formError,
      ];
}

class ReportDetailsLoadFailure extends ReportDetailsState {
  final String error;
  ReportDetailsLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
