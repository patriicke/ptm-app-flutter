part of 'commstab_bloc.dart';

abstract class CommstabState extends Equatable {
  const CommstabState();

  @override
  List<Object> get props => [];
}

class CommstabLoadingInProgress extends CommstabState {}

class CommstabLoadSuccess extends CommstabState {
  final int unreadContactMessagesCount;
  final List<ChatContactDto> contactChats;
  final List<Meeting> attendedMeetings;

  const CommstabLoadSuccess({
    this.unreadContactMessagesCount,
    this.contactChats,
    this.attendedMeetings,
  });

  @override
  List<Object> get props => [
        unreadContactMessagesCount,
        contactChats,
        attendedMeetings,
      ];
}

class CommstabLoadingFailed extends CommstabState {
  final String error;

  const CommstabLoadingFailed(this.error);

  @override
  List<Object> get props => [error];
}
