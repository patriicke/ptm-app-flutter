import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meetings/signup/models/date_of_birth.dart';
import 'package:meetings/models/gender.dart';
import 'package:meetings/signup/models/profile_photo.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

part 'profile_completion_event.dart';
part 'profile_completion_state.dart';

class ProfileCompletionBloc
    extends Bloc<ProfileCompletionEvent, ProfileCompletionState> {
  ProfileCompletionBloc({
    @required UserRepository userRepository,
    @required AuthenticationRepository authenticationRepository,
  })  : assert(userRepository != null),
        assert(authenticationRepository != null),
        _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(const ProfileCompletionState());

  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<ProfileCompletionState> mapEventToState(
    ProfileCompletionEvent event,
  ) async* {
    if (event is ProfileCompletionStarted) {
      yield _mapProfileCompletionStartedToState(event, state);
    } else if (event is ProfilePhotoUpdated) {
      yield _mapProfilePhotoUpdatedToState(event, state);
    } else if (event is GenderUpdated) {
      yield _mapGenderUpdatedToState(event, state);
    } else if (event is DateOfBirthUpdated) {
      yield _mapDateOfBirthUpdatedToState(event, state);
    } else if (event is ProfileCompletionSubmitted) {
      yield* _mapProfileCompletionSubmittedToState(event, state);
    }
  }

  ProfileCompletionState _mapProfileCompletionStartedToState(
    ProfileCompletionStarted event,
    ProfileCompletionState state,
  ) {
    return ProfileCompletionState();
  }

  ProfileCompletionState _mapProfilePhotoUpdatedToState(
    ProfilePhotoUpdated event,
    ProfileCompletionState state,
  ) {
    final profilePhoto = ProfilePhoto.dirty(event.profilePhoto);
    return state.copyWith(
      profilePhoto: profilePhoto,
      status: Formz.validate([
        profilePhoto,
        state.gender,
        state.dateOfBirth,
      ]),
    );
  }

  ProfileCompletionState _mapGenderUpdatedToState(
    GenderUpdated event,
    ProfileCompletionState state,
  ) {
    final gender = Gender.dirty(event.gender);
    return state.copyWith(
      gender: gender,
      status: Formz.validate([
        state.profilePhoto,
        gender,
        state.dateOfBirth,
      ]),
    );
  }

  ProfileCompletionState _mapDateOfBirthUpdatedToState(
    DateOfBirthUpdated event,
    ProfileCompletionState state,
  ) {
    final dateOfBirth = DateOfBirth.dirty(event.dateOfBirth);
    return state.copyWith(
      dateOfBirth: dateOfBirth,
      status: Formz.validate([
        state.profilePhoto,
        state.gender,
        dateOfBirth,
      ]),
    );
  }

  Stream<ProfileCompletionState> _mapProfileCompletionSubmittedToState(
    ProfileCompletionSubmitted event,
    ProfileCompletionState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        var userId = _authenticationRepository.currentUser.id;
        var authKey = _authenticationRepository.authKey;
        var vm = ProfileCompletionVm();
        vm.profileImagePath = state.profilePhoto.value;
        vm.gender = state.gender.value.toString();
        vm.dateOfBirth = state.dateOfBirth.value;
        await _userRepository.completeUserProfile(userId, authKey, vm);
        if (_authenticationRepository.loginType == LoginType.parent) {
          await _authenticationRepository
              .updateUserStatus(UserStatus.parentProfileCompleted);
        } else {
          await _authenticationRepository
              .updateUserStatus(UserStatus.teacherProfileCompleted);
        }
        yield state.copyWith(
          profilePhoto: ProfilePhoto.pure(),
          gender: Gender.pure(),
          dateOfBirth: DateOfBirth.pure(),
          status: FormzStatus.submissionSuccess,
        );
      } catch (e) {
        log(e.toString());
        yield state.copyWith(
          status: FormzStatus.submissionFailure,
          error: e.toString(),
        );
      }
    }
  }
}
