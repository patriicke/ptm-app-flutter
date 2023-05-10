import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meetings/home/models/meeting_request.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

part 'meeting_request_event.dart';
part 'meeting_request_state.dart';

class MeetingRequestBloc
    extends Bloc<MeetingRequestEvent, MeetingRequestState> {
  MeetingRequestBloc({
    @required AuthenticationRepository authenticationRepository,
    @required MeetingsRepository meetingRepository,
    @required UserRepository userRepository,
  })  : assert(authenticationRepository != null),
        assert(meetingRepository != null),
        assert(userRepository != null),
        _meetingRepository = meetingRepository,
        _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const MeetingRequestState());

  final AuthenticationRepository _authenticationRepository;
  final MeetingsRepository _meetingRepository;
  final UserRepository _userRepository;

  @override
  Stream<MeetingRequestState> mapEventToState(
    MeetingRequestEvent event,
  ) async* {
    if (event is MeetingTitleUpdated) {
      yield _mapMeetingTitleUpdatedToState(event, state);
    } else if (event is MeetingRecipientUpdated) {
      yield _mapMeetingRecipientUpdatedToState(event, state);
    } else if (event is MeetingDateUpdated) {
      yield _mapMeetingDateUpdatedToState(event, state);
    } else if (event is MeetingTimeUpdated) {
      yield _mapMeetingTimeUpdatedToState(event, state);
    } else if (event is MeetingRequestSubmitted) {
      yield* _mapMeetingRequestSubmittedToState(event, state);
    } else if (event is RecipientSearchRequested) {
      yield* _mapRecipientSearchRequestedToState(event, state);
    } else if (event is RecipientSelected) {
      yield _mapRecipientSelectedToState(event, state);
    } else if (event is RecipientPreselected) {
      yield _mapRecipientPreselectedToState(event, state);
    }
  }

  MeetingRequestState _mapMeetingTitleUpdatedToState(
    MeetingTitleUpdated event,
    MeetingRequestState state,
  ) {
    log(event.toString());
    final meetingTitle = MeetingTitle.dirty(event.meetingTitle);
    return state.copyWith(
      meetingTitle: meetingTitle,
      status: Formz.validate(
        [
          meetingTitle,
          state.meetingRecipient,
          state.meetingDate,
          state.meetingTime,
        ],
      ),
    );
  }

  MeetingRequestState _mapMeetingRecipientUpdatedToState(
    MeetingRecipientUpdated event,
    MeetingRequestState state,
  ) {
    log(event.toString());
    final meetingParent = MeetingRecipient.dirty(event.meetingParent);
    return state.copyWith(
      meetingParent: meetingParent,
      status: Formz.validate([
        state.meetingTitle,
        meetingParent,
        state.meetingDate,
        state.meetingTime,
      ]),
    );
  }

  Stream<MeetingRequestState> _mapRecipientSearchRequestedToState(
    RecipientSearchRequested event,
    MeetingRequestState state,
  ) async* {
    log(event.toString());
    if (!state.meetingRecipient.pure) {
      yield state.copyWith(searchStatus: FormzStatus.submissionInProgress);
      try {
        // If current user type is parent (0) search for teachers, otherwise, search for parents
        var users = _authenticationRepository.currentUser.userType == 0
            ? await _userRepository.searchTeachers(
                _authenticationRepository.authKey,
                state.meetingRecipient.value,
              )
            : await _userRepository.searchParents(
                _authenticationRepository.authKey,
                state.meetingRecipient.value,
              );
        yield state.copyWith(
          searchStatus: FormzStatus.submissionSuccess,
          searchedUsers: users,
        );
      } catch (e) {
        yield state.copyWith(
          searchStatus: FormzStatus.submissionFailure,
          error: e.toString(),
        );
      }
    }
  }

  MeetingRequestState _mapRecipientSelectedToState(
      RecipientSelected event, MeetingRequestState state) {
    log(event.toString());

    if (!state.selectedRecipientUsers
        .any((recipient) => recipient.userId == event.selectedUserId)) {
      var selectedUser = state.searchedUsers
          .where((searchedUser) => searchedUser.id == event.selectedUserId)
          .first;
      var newRecipient = CreateMeetingVmUsers()
        ..userId = selectedUser.id
        ..userType = selectedUser.userType;

      var updatedRecipients = List<CreateMeetingVmUsers>();
      state.selectedRecipientUsers.forEach((recipient) {
        updatedRecipients.add(recipient);
      });
      updatedRecipients.add(newRecipient);

      return state.copyWith(
        selectedRecipientUsers: updatedRecipients,
        searchStatus: FormzStatus.pure,
        searchedUsers: [],
      );
    } else
      return state;
  }

  MeetingRequestState _mapRecipientPreselectedToState(
      RecipientPreselected event, MeetingRequestState state) {
    var selectedUser = new CreateMeetingVmUsers()
      ..userId = event.userId
      ..userType = event.userType;
    var recipients = <CreateMeetingVmUsers>[selectedUser];
    return state.copyWith(selectedRecipientUsers: recipients);
  }

  MeetingRequestState _mapMeetingDateUpdatedToState(
    MeetingDateUpdated event,
    MeetingRequestState state,
  ) {
    log(event.toString());
    final meetingDate = MeetingDate.dirty(event.meetingDate);
    return state.copyWith(
      meetingDate: meetingDate,
      status: Formz.validate([
        state.meetingTitle,
        state.meetingRecipient,
        meetingDate,
        state.meetingTime,
      ]),
    );
  }

  MeetingRequestState _mapMeetingTimeUpdatedToState(
    MeetingTimeUpdated event,
    MeetingRequestState state,
  ) {
    log(event.toString());
    final meetingTime = MeetingTime.dirty(event.meetingTime);
    return state.copyWith(
      meetingTime: meetingTime,
      status: Formz.validate([
        state.meetingTitle,
        state.meetingRecipient,
        state.meetingDate,
        meetingTime,
      ]),
    );
  }

  Stream<MeetingRequestState> _mapMeetingRequestSubmittedToState(
    MeetingRequestSubmitted event,
    MeetingRequestState state,
  ) async* {
    log(event.toString());
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        var meetingVm = new CreateMeetingVm();
        // var meetingVmUser = new CreateMeetingVmUsers();
        // meetingVmUser.userId = state.selectedRecipientUsers.id;
        // meetingVmUser.userType = state.selectedRecipientUsers.userType;

        meetingVm.title = state.meetingTitle.value;
        var tempMeetingDate = DateTime.parse(state.meetingDate.value);
        var tempMeetingTime = DateTime.parse(state.meetingTime.value);
        var tempMeetingDateTime = DateTime(
          tempMeetingDate.year,
          tempMeetingDate.month,
          tempMeetingDate.day,
          tempMeetingTime.hour,
          tempMeetingTime.minute,
          tempMeetingTime.second,
          tempMeetingTime.millisecond,
          tempMeetingTime.microsecond,
        );
        meetingVm.meetingStartsOn = tempMeetingDateTime.toIso8601String();
        meetingVm.users = state.selectedRecipientUsers;
        await _meetingRepository.createNewMeeting(
          _authenticationRepository.authKey,
          meetingVm,
        );
        yield state.copyWith(
          meetingTitle: MeetingTitle.pure(),
          meetingParent: MeetingRecipient.pure(),
          meetingDate: MeetingDate.pure(),
          meetingTime: MeetingTime.pure(),
          status: FormzStatus.submissionSuccess,
        );
      } catch (e) {
        yield state.copyWith(
          status: FormzStatus.submissionFailure,
          error: e.toString(),
        );
      }
    }
  }
}
