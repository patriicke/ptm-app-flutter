part of 'notifications_list_bloc.dart';

abstract class NotificationsListEvent extends Equatable {
  const NotificationsListEvent();

  @override
  List<Object> get props => [];
}

enum NotificationFilterType { all, seen, unseen }

class NotificationsListLoaded extends NotificationsListEvent {
  final NotificationFilterType filterType;
  const NotificationsListLoaded({this.filterType});

  @override
  List<Object> get props => [filterType];
}
