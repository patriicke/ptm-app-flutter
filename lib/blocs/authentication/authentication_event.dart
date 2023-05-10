part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

class CurrentUserUpdated extends AuthenticationEvent {
  final currentUser;

  const CurrentUserUpdated(this.currentUser);

  @override
  List<Object> get props => [currentUser];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
