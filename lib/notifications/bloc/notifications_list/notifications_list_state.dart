part of 'notifications_list_bloc.dart';

abstract class NotificationsListState extends Equatable {
  const NotificationsListState();

  @override
  List<Object> get props => [];
}

class NotificationsListLoadInProgress extends NotificationsListState {}

class NotificationsListLoadSuccess extends NotificationsListState {
  final List<NotificationDto> notifications;
  final List<MeetingRequestDto> meetingRequests;
  final List<ParentTeacherConnectionRequestDto> connectionRequests;

  NotificationsListLoadSuccess(
      this.notifications, this.meetingRequests, this.connectionRequests);

  @override
  List<Object> get props =>
      [notifications, meetingRequests, connectionRequests];
}

class NotificationsListLoadFailure extends NotificationsListState {
  final String error;

  NotificationsListLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
