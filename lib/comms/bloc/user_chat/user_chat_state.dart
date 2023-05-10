part of 'user_chat_bloc.dart';

abstract class UserChatState extends Equatable {
  const UserChatState();

  @override
  List<Object> get props => [];
}

class ChatLoadInProgress extends UserChatState {}

class ChatLoadSuccess extends UserChatState {
  final TextMessage textMessage;
  final FormzStatus textMessageStatus;
  final String messageSubmissionError;
  final List<ChatMessage> messages;
  final String contactUserName;
  final String contactUserId;
  final String contactUserDescription;
  final int contactUserType;

  ChatLoadSuccess({
    this.textMessage = const TextMessage.pure(),
    this.textMessageStatus = FormzStatus.pure,
    this.messageSubmissionError,
    this.messages = const [],
    this.contactUserId,
    this.contactUserName,
    this.contactUserDescription,
    this.contactUserType,
  });

  ChatLoadSuccess copyWith({
    TextMessage textMessage,
    FormzStatus textMessageStatus,
    String messsageSubmissionError,
    List<ChatMessage> messages,
    String contactUserId,
    String contactUserName,
    String contactUserDescription,
    int contactUserType,
  }) {
    return ChatLoadSuccess(
      textMessage: textMessage ?? this.textMessage,
      textMessageStatus: textMessageStatus ?? this.textMessageStatus,
      messageSubmissionError:
          messageSubmissionError ?? this.messageSubmissionError,
      messages: messages ?? this.messages,
      contactUserId: contactUserId ?? this.contactUserId,
      contactUserName: contactUserName ?? this.contactUserName,
      contactUserDescription:
          contactUserDescription ?? this.contactUserDescription,
      contactUserType: contactUserType ?? this.contactUserType,
    );
  }

  @override
  List<Object> get props => [
        textMessage,
        textMessageStatus,
        messageSubmissionError,
        messages,
        contactUserId,
        contactUserName,
        contactUserDescription,
        contactUserType,
      ];
}

class ChatLoadFailure extends UserChatState {
  final String error;

  ChatLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
