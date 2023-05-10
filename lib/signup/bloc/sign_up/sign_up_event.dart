part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpStarted extends SignUpEvent {
  final int signupType;
  const SignUpStarted(this.signupType);

  @override
  List<Object> get props => [signupType];
}

class FullNameUpdated extends SignUpEvent {
  const FullNameUpdated(this.fullName);
  final String fullName;

  @override
  List<Object> get props => [fullName];
}

class EmailUpdated extends SignUpEvent {
  const EmailUpdated(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordUpdated extends SignUpEvent {
  const PasswordUpdated(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

class MobileNoUpdated extends SignUpEvent {
  const MobileNoUpdated(this.mobileNo);
  final String mobileNo;

  @override
  List<Object> get props => [mobileNo];
}

class AboutUpdated extends SignUpEvent {
  const AboutUpdated(this.about);
  final String about;

  @override
  List<Object> get props => [about];
}

class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted();
}
