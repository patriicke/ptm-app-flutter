part of 'meetings_home_bloc.dart';

abstract class MeetingsHomeState extends Equatable {
  const MeetingsHomeState();

  @override
  List<Object> get props => [];
}

class MeetingsLoadInProgress extends MeetingsHomeState {}

class MeetingsLoadSuccess extends MeetingsHomeState {
  final List<Meeting> meetings;
  final EventList<Event> meetingEvents;
  final String updateError;
  const MeetingsLoadSuccess({
    this.meetings = const [],
    this.updateError,
    this.meetingEvents,
  });

  @override
  List<Object> get props => [meetings, updateError, meetingEvents];

  @override
  String toString() =>
      'MeetingsLoadSuccess { meetings: $meetings, updateError: $updateError, meetingEvents: $meetingEvents }';
}

class MeetingsLoadFailure extends MeetingsHomeState {
  final String error;
  const MeetingsLoadFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'MeetingsLoadFailure { error: $error }';
}
