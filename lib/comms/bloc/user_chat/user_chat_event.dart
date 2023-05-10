part of 'user_chat_bloc.dart';

abstract class UserChatEvent extends Equatable {
  const UserChatEvent();

  @override
  List<Object> get props => [];
}

// ChatMessagesLoaded, MessageUpdated, MessageSubmitted

class ChatMessagesLoaded extends UserChatEvent {
  final String contactUserId;
  const ChatMessagesLoaded(this.contactUserId);

  @override
  List<Object> get props => [contactUserId];
}

class ChatMessagesInternalLoaded extends UserChatEvent {
  const ChatMessagesInternalLoaded();
}

class MessageUpdated extends UserChatEvent {
  final String message;
  const MessageUpdated(this.message);

  @override
  List<Object> get props => [message];
}

class MessageSubmitted extends UserChatEvent {
  const MessageSubmitted();
}
