part of 'meetings_home_bloc.dart';

abstract class MeetingsHomeEvent extends Equatable {
  const MeetingsHomeEvent();

  @override
  List<Object> get props => [];
}

class MeetingsLoaded extends MeetingsHomeEvent {}

class MeetingStatusToggled extends MeetingsHomeEvent {
  final String meetingId;
  const MeetingStatusToggled(this.meetingId);

  @override
  List<Object> get props => [meetingId];

  @override
  String toString() => 'MeetingStatusToggled { meetingId: $meetingId }';
}

class MeetingEntered extends MeetingsHomeEvent {
  final String meetingId;
  const MeetingEntered(this.meetingId);

  @override
  List<Object> get props => [meetingId];

  @override
  String toString() => 'MeetingEntered { meetingId: $meetingId }';
}
