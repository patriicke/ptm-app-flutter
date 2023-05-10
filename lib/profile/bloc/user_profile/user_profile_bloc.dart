import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc({
    @required AuthenticationRepository authenticationRepository,
    @required UserRepository userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(UserProfileLoadingInProgress());

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  @override
  Stream<UserProfileState> mapEventToState(
    UserProfileEvent event,
  ) async* {
    if (event is UserProfileLoaded) {
      yield* _mapUserProfileLoadedToState();
    } else if (event is InviteLinkRequested) {
      yield* _mapInviteLinkRequestedToState(event, state);
    } else if (event is NotificationSettingToggled) {
      yield _mapNotificationSettingToggledToState(event, state);
    } else if (event is NotificationSettingToggled) {
      yield _mapNotificationSettingToggledToState(event, state);
    } else if (event is WhoCanSeeScheduleUpdated) {
      yield _mapWhoCanSeeScheduleUpdatedToState(event, state);
    } else if (event is LogoutRequested) {
      await _authenticationRepository.logOut();
    }
  }

  Stream<UserProfileState> _mapUserProfileLoadedToState() async* {
    yield UserProfileLoadingInProgress();

    try {
      var userId = _authenticationRepository.currentUser.id;
      var authKey = _authenticationRepository.authKey;
      var userDetails =
          await _userRepository.getCurrentUserById(userId, authKey);

      yield UserProfileLoadSuccess(
        userDetails: userDetails,
      );
    } catch (e) {
      yield UserProfileLoadFailure(e.toString());
    }
  }

  Stream<UserProfileState> _mapInviteLinkRequestedToState(
    InviteLinkRequested event,
    UserProfileState state,
  ) async* {
    if (state is UserProfileLoadSuccess) {
      yield state.copyWith(
        inviteLinkStatus: FormzStatus.submissionInProgress,
        inviteLinkError: null,
      );

      try {
        var userId = _authenticationRepository.currentUser.id;
        var authKey = _authenticationRepository.authKey;

        var userApi = UserApi();
        var response = await userApi.getInviteLink(userId, authKey);

        if (response.apiResponseMessage.code != 200) {
          log('Exception when calling UserApi->getInviteLink. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
          throw Exception(
              'Exception when calling UserApi->getInviteLink. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
        }
        yield state.copyWith(
          inviteLinkStatus: FormzStatus.submissionSuccess,
          inviteLink: response.data,
          inviteLinkError: null,
        );
      } catch (e) {
        yield state.copyWith(
          inviteLinkStatus: FormzStatus.submissionFailure,
          inviteLinkError: e.toString(),
        );
      }
    } else
      yield state;
  }

  UserProfileState _mapNotificationSettingToggledToState(
    NotificationSettingToggled event,
    UserProfileState state,
  ) {
    if (state is UserProfileLoadSuccess) {
      return state.copyWith(
        notificationEnabled: !state.notificationEnabled,
      );
    } else
      return state;
  }

  UserProfileState _mapWhoCanSeeScheduleUpdatedToState(
    WhoCanSeeScheduleUpdated event,
    UserProfileState state,
  ) {
    if (state is UserProfileLoadSuccess) {
      return state.copyWith(
        whoCanSee: event.availability,
      );
    } else
      return state;
  }
}
