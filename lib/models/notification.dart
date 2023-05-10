import 'package:equatable/equatable.dart';

class UserNotification extends Equatable {
  const UserNotification({
    this.by,
    this.message,
    this.seen,
    this.notificationDate,
  });
  final String by;
  final String message;
  final bool seen;
  final DateTime notificationDate;
  @override
  List<Object> get props => [
        by,
        message,
        seen,
        notificationDate,
      ];
}
