import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

part 'contact_selection_event.dart';
part 'contact_selection_state.dart';

class ContactSelectionBloc
    extends Bloc<ContactSelectionEvent, ContactSelectionState> {
  ContactSelectionBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(ContactSelectionLoadInProgress());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<ContactSelectionState> mapEventToState(
    ContactSelectionEvent event,
  ) async* {
    if (event is ContactSelectionLoaded) {
      yield* _mapContactSelectionLoadedToState(event, state);
    }
  }

  Stream<ContactSelectionState> _mapContactSelectionLoadedToState(
    ContactSelectionLoaded event,
    ContactSelectionState state,
  ) async* {
    yield ContactSelectionLoadInProgress();
    try {
      var authKey = _authenticationRepository.authKey;
      var userId = _authenticationRepository.currentUser.id;
      var chatApi = ChatApi();
      var response = await chatApi.searchChatContacts(authKey, userId);

      if (response.apiResponseMessage.code != 200) {
        log('Exception when calling ChatApi->getChatContacts. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
        throw Exception(
            'Exception when calling UserApi->getChatContacts. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
      }
      yield ContactSelectionLoadSuccess(response.data);
    } catch (e) {
      yield ContactSelectionLoadFailure(e.toString());
    }
  }
}
