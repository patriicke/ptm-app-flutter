import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meetings/notifications/screen/meeting_approval.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

part 'meeting_approval_event.dart';
part 'meeting_approval_state.dart';

class MeetingApprovalBloc
    extends Bloc<MeetingApprovalEvent, MeetingApprovalState> {
  MeetingApprovalBloc({
    @required MeetingRequestDto meetingRequest,
    @required AuthenticationRepository authenticationRepository,
  })  : assert(meetingRequest != null),
        assert(authenticationRepository != null),
        _meetingRequest = meetingRequest,
        _authenticationRepository = authenticationRepository,
        super(MeetingApprovalLoadInProgress());

  final MeetingRequestDto _meetingRequest;
  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<MeetingApprovalState> mapEventToState(
    MeetingApprovalEvent event,
  ) async* {
    if (event is MeetingApprovalLoaded) {
      yield _mapMeetingApprovalLoadedToState();
    } else if (event is MeetingApprovalApproved) {
      yield* _mapMeetingApprovalApprovedToState();
    } else if (event is MeetingApprovalRejected) {
      yield* _mapMeetingApprovalRejectedToState();
    }
  }

  MeetingApprovalState _mapMeetingApprovalLoadedToState() {
    return MeetingApprovalLoadSuccess(
      performedAction: PerformedAction.none,
      meetingRequest: _meetingRequest,
    );
  }

  Stream<MeetingApprovalState> _mapMeetingApprovalApprovedToState() async* {
    yield MeetingApprovalLoadInProgress();

    try {
      var authKey = _authenticationRepository.authKey;
      var userId = _authenticationRepository.currentUser.id;
      var meetingApi = MeetingApi();
      await meetingApi.updateMeetingAttendanceStatus(
          _meetingRequest.meetingId, authKey, userId, 1);
      yield MeetingApprovalLoadSuccess(
        performedAction: PerformedAction.approved,
        meetingRequest: _meetingRequest,
      );
    } catch (e) {
      yield MeetingApprovalLoadFailure(e.toString());
    }
  }

  Stream<MeetingApprovalState> _mapMeetingApprovalRejectedToState() async* {
    yield MeetingApprovalLoadInProgress();

    try {
      var authKey = _authenticationRepository.authKey;
      var userId = _authenticationRepository.currentUser.id;
      var meetingApi = MeetingApi();
      await meetingApi.updateMeetingAttendanceStatus(
          _meetingRequest.meetingId, authKey, userId, 0);
      yield MeetingApprovalLoadSuccess(
        performedAction: PerformedAction.rejected,
        meetingRequest: _meetingRequest,
      );
    } catch (e) {
      yield MeetingApprovalLoadFailure(e.toString());
    }
  }
}
