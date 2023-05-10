part of 'login_type_bloc.dart';

abstract class LoginTypeEvent extends Equatable {
  const LoginTypeEvent();
}

class LoginTypeUpdated extends LoginTypeEvent {
  final LoginType loginType;

  const LoginTypeUpdated(this.loginType);

  @override
  List<Object> get props => [loginType];

  @override
  String toString() => 'LoginTypeUpdated {type $loginType}';
}

class LoginTypeStreamedIn extends LoginTypeEvent {
  final LoginType loginType;

  const LoginTypeStreamedIn(this.loginType);

  @override
  List<Object> get props => [loginType];

  @override
  String toString() => 'LoginTypeStreamedIn {type $loginType}';
}
