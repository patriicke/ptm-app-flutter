import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart';
import 'package:meetings/comms/models/text_message.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

part 'user_chat_event.dart';
part 'user_chat_state.dart';

class UserChatBloc extends Bloc<UserChatEvent, UserChatState> {
  UserChatBloc({
    @required AuthenticationRepository authenticationRepository,
    @required ChatRepository chatRepository,
  })  : assert(authenticationRepository != null),
        assert(chatRepository != null),
        _authenticationRepository = authenticationRepository,
        _chatRepository = chatRepository,
        super(ChatLoadInProgress()) {
    const fiveSec = const Duration(seconds: 5);
    _timer = new Timer.periodic(fiveSec, (Timer timer) {
      add(ChatMessagesInternalLoaded());
    });
  }

  final AuthenticationRepository _authenticationRepository;
  final ChatRepository _chatRepository;
  Timer _timer;

  @override
  Stream<UserChatState> mapEventToState(
    UserChatEvent event,
  ) async* {
    if (event is ChatMessagesLoaded) {
      yield* _mapChatMessagesLoadedToState(event);
    } else if (event is MessageUpdated) {
      yield _mapMessageUpdatedToState(event, state);
    } else if (event is MessageSubmitted) {
      yield* _mapMessageSubmittedToState(event, state);
    } else if (event is ChatMessagesInternalLoaded) {
      yield* _mapChatMessagesInternalLoadedToState(event, state);
    }
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }

  Stream<UserChatState> _mapChatMessagesLoadedToState(
      ChatMessagesLoaded event) async* {
    yield ChatLoadInProgress();
    try {
      var authKey = _authenticationRepository.authKey;
      var userId = _authenticationRepository.currentUser.id;
      var messagesResponse = await _chatRepository.getChatMessages(
          authKey, userId, event.contactUserId);

      yield ChatLoadSuccess(
        contactUserId: messagesResponse.contactUserId,
        contactUserName: messagesResponse.contactUserName,
        contactUserDescription: messagesResponse.contactUserDescription,
        contactUserType: messagesResponse.contactUserType,
        messages: messagesResponse.messages,
      );
    } catch (e) {
      yield ChatLoadFailure(e.toString());
    }
  }

  Stream<UserChatState> _mapChatMessagesInternalLoadedToState(
    ChatMessagesInternalLoaded event,
    UserChatState state,
  ) async* {
    if (state is ChatLoadSuccess) {
      try {
        var authKey = _authenticationRepository.authKey;
        var userId = _authenticationRepository.currentUser.id;
        var messagesResponse = await _chatRepository.getChatMessages(
            authKey, userId, state.contactUserId);

        log('chat reloaded: ${DateTime.now().toString()}');
        log(messagesResponse.toString());

        yield ChatLoadSuccess(
          contactUserId: messagesResponse.contactUserId,
          contactUserName: messagesResponse.contactUserName,
          contactUserDescription: messagesResponse.contactUserDescription,
          contactUserType: messagesResponse.contactUserType,
          messages: messagesResponse.messages,
        );
      } catch (e) {
        if (e is ClientException) {
          log(e.toString());
          yield state;
        } else {
          yield ChatLoadFailure(e.toString());
        }
      }
    }
  }

  UserChatState _mapMessageUpdatedToState(
      MessageUpdated event, UserChatState state) {
    if (state is ChatLoadSuccess) {
      var message = TextMessage.dirty(event.message);

      return state.copyWith(
        textMessage: message,
        textMessageStatus: Formz.validate([message]),
      );
    } else
      return state;
  }

  Stream<UserChatState> _mapMessageSubmittedToState(
      MessageSubmitted event, UserChatState state) async* {
    if (state is ChatLoadSuccess) {
      yield state.copyWith(textMessageStatus: FormzStatus.submissionInProgress);
      try {
        var authKey = _authenticationRepository.authKey;
        var userId = _authenticationRepository.currentUser.id;
        var response = await _chatRepository.sendMessage(
          authKey,
          userId,
          state.contactUserId,
          state.textMessage.value,
        );
        var updatedMessages = state.messages.map((e) => e).toList();
        updatedMessages.add(response);
        yield state.copyWith(
          messages: updatedMessages,
          textMessageStatus: FormzStatus.submissionSuccess,
          textMessage: TextMessage.pure(),
          messsageSubmissionError: null,
        );
      } catch (e) {
        state.copyWith(messsageSubmissionError: e.toString());
      }
    }
  }
}
