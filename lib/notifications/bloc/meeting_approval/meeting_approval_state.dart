part of 'meeting_approval_bloc.dart';

abstract class MeetingApprovalState extends Equatable {
  const MeetingApprovalState();

  @override
  List<Object> get props => [];
}

class MeetingApprovalLoadInProgress extends MeetingApprovalState {}

enum PerformedAction { none, approved, rejected }

class MeetingApprovalLoadSuccess extends MeetingApprovalState {
  final PerformedAction performedAction;
  final MeetingRequestDto meetingRequest;
  MeetingApprovalLoadSuccess({
    this.performedAction,
    this.meetingRequest,
  });

  @override
  List<Object> get props => [performedAction, meetingRequest];
}

class MeetingApprovalLoadFailure extends MeetingApprovalState {
  final String error;
  MeetingApprovalLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
