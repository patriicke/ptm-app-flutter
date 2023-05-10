import 'package:equatable/equatable.dart';

class UserMessage extends Equatable {
  const UserMessage({
    this.message,
    this.by,
    this.byTitle,
    this.byMe,
    this.messageOn,
  });
  final String message;
  final String by;
  final String byTitle;
  final bool byMe;
  final DateTime messageOn;

  @override
  List<Object> get props => [message, by, byTitle, byMe, messageOn];
}
