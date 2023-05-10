part of 'meeting_approval_bloc.dart';

abstract class MeetingApprovalEvent extends Equatable {
  const MeetingApprovalEvent();

  @override
  List<Object> get props => [];
}

class MeetingApprovalLoaded extends MeetingApprovalEvent {
  const MeetingApprovalLoaded();
}

class MeetingApprovalApproved extends MeetingApprovalEvent {
  const MeetingApprovalApproved();
}

class MeetingApprovalRejected extends MeetingApprovalEvent {
  const MeetingApprovalRejected();
}
