import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

part 'contact_details_event.dart';
part 'contact_details_state.dart';

class ContactDetailsBloc
    extends Bloc<ContactDetailsEvent, ContactDetailsState> {
  ContactDetailsBloc({
    @required AuthenticationRepository authenticationRepository,
    @required ChatRepository chatRepository,
  })  : assert(authenticationRepository != null),
        assert(chatRepository != null),
        _authenticationRepository = authenticationRepository,
        _chatRepository = chatRepository,
        super(ContactDetailsLoadInProgress());

  final AuthenticationRepository _authenticationRepository;
  final ChatRepository _chatRepository;

  @override
  Stream<ContactDetailsState> mapEventToState(
    ContactDetailsEvent event,
  ) async* {
    if (event is ContactDetailsLoaded) {
      yield* _mapContactDetailsLoadedToState(event);
    }
  }

  Stream<ContactDetailsState> _mapContactDetailsLoadedToState(
    ContactDetailsLoaded event,
  ) async* {
    yield ContactDetailsLoadInProgress();
    try {
      var authKey = _authenticationRepository.authKey;
      var userId = _authenticationRepository.currentUser.id;
      if (event.contactUserType == 0) {
        var contactUserDetails = await _chatRepository.getParentContactDetails(
            authKey, userId, event.contactUserId);
        yield ContactDetailsLoadSuccess(
          contactUser: contactUserDetails,
          contactUserDescription: event.contactUserDescription,
          isTeacher: false,
        );
      } else {
        var contactUserDetails = await _chatRepository.getTeacherContactDetails(
            authKey, userId, event.contactUserId);
        yield ContactDetailsLoadSuccess(
          contactUser: contactUserDetails.teacher,
          contactUserDescription: event.contactUserDescription,
          isTeacher: true,
          teacherAvailability: contactUserDetails.weeklyAvailability,
        );
      }
    } catch (e) {
      yield ContactDetailsLoadFailure(e.toString());
    }
  }
}
