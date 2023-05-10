import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

part 'commstab_event.dart';
part 'commstab_state.dart';

// NOTE: The read status of a chat message is updated at server side whenever a user loads a message from the server on the chat screen
class CommstabBloc extends Bloc<CommstabEvent, CommstabState> {
  CommstabBloc({
    @required AuthenticationRepository authenticationRepository,
    @required MeetingsRepository meetingsRepository,
    @required ChatRepository chatRepository,
  })  : assert(authenticationRepository != null),
        assert(meetingsRepository != null),
        assert(chatRepository != null),
        _authenticationRepository = authenticationRepository,
        _meetingsRepository = meetingsRepository,
        _chatRepository = chatRepository,
        super(CommstabLoadingInProgress());

  final AuthenticationRepository _authenticationRepository;
  final MeetingsRepository _meetingsRepository;
  final ChatRepository _chatRepository;

  @override
  Stream<CommstabState> mapEventToState(
    CommstabEvent event,
  ) async* {
    if (event is CommstabLoaded) {
      yield* _mapCommstabLoadedToState();
    }
  }

  Stream<CommstabState> _mapCommstabLoadedToState() async* {
    yield CommstabLoadingInProgress();
    try {
      var authKey = _authenticationRepository.authKey;
      var userId = _authenticationRepository.currentUser.id;
      var chatContacts = await _chatRepository.getChatContacts(authKey, userId);
      var attendedMeetings =
          await _meetingsRepository.getEnteredMeetings(authKey);
      var unreadMessagesCount = chatContacts
          .where((contact) => contact.unreadMessagesCount > 0)
          .length;
      yield CommstabLoadSuccess(
        unreadContactMessagesCount: unreadMessagesCount,
        contactChats: chatContacts,
        attendedMeetings: attendedMeetings,
      );
    } catch (e) {
      yield CommstabLoadingFailed(e.toString());
    }
  }
}
