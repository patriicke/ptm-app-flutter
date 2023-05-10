part of 'meeting_request_bloc.dart';

abstract class MeetingRequestEvent extends Equatable {
  const MeetingRequestEvent();

  @override
  List<Object> get props => [];
}

class MeetingTitleUpdated extends MeetingRequestEvent {
  const MeetingTitleUpdated(this.meetingTitle);
  final String meetingTitle;

  @override
  List<Object> get props => [meetingTitle];

  @override
  String toString() => 'MeetingTitleUpdated { meetingTitle: $meetingTitle }';
}

class MeetingRecipientUpdated extends MeetingRequestEvent {
  const MeetingRecipientUpdated(this.meetingParent);
  final String meetingParent;

  @override
  List<Object> get props => [meetingParent];

  @override
  String toString() =>
      'MeetingRecipientUpdated { meetingParent: $meetingParent }';
}

class RecipientSearchRequested extends MeetingRequestEvent {
  const RecipientSearchRequested();
}

class RecipientSelected extends MeetingRequestEvent {
  final String selectedUserId;
  const RecipientSelected(this.selectedUserId);

  @override
  List<Object> get props => [selectedUserId];

  @override
  String toString() => 'RecipientSelected { selectedUserId: $selectedUserId }';
}

class RecipientPreselected extends MeetingRequestEvent {
  final String userId;
  final String userName;
  final int userType;

  const RecipientPreselected(this.userId, this.userName, this.userType);

  @override
  List<Object> get props => [userId, userName, userType];
}

class MeetingDateUpdated extends MeetingRequestEvent {
  const MeetingDateUpdated(this.meetingDate);
  final String meetingDate;

  @override
  List<Object> get props => [meetingDate];

  @override
  String toString() => 'MeetingDateUpdated { meetingDate: $meetingDate }';
}

class MeetingTimeUpdated extends MeetingRequestEvent {
  const MeetingTimeUpdated(this.meetingTime);
  final String meetingTime;

  @override
  List<Object> get props => [meetingTime];

  @override
  String toString() => 'MeetingTimeUpdated { meetingTime: $meetingTime }';
}

class MeetingRequestSubmitted extends MeetingRequestEvent {
  const MeetingRequestSubmitted();
}
