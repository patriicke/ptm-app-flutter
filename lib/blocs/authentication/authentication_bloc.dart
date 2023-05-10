import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
    @required UserRepository userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
    _currentUserSubscription = _authenticationRepository.currentUserStream
        .listen((user) => add(CurrentUserUpdated(user)));
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;
  StreamSubscription<UserEntity> _currentUserSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      await _authenticationRepository.logOut();
    } else if (event is CurrentUserUpdated) {
      yield await _mapCurrentUserUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription?.cancel();
    _currentUserSubscription?.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return const AuthenticationState.unauthenticated();
      case AuthenticationStatus.verifying:
        final user = _authenticationRepository.currentUser;
        return user != null
            ? AuthenticationState.verifying(user)
            : const AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
        final user = _authenticationRepository.currentUser;
        return user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated();
      default:
        return const AuthenticationState.unknown();
    }
  }

  Future<AuthenticationState> _mapCurrentUserUpdatedToState(
      CurrentUserUpdated event) async {
    return event.currentUser != null
        ? AuthenticationState.authenticated(event.currentUser)
        : const AuthenticationState.unauthenticated();
  }
}
