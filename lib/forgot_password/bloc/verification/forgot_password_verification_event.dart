part of 'forgot_password_verification_bloc.dart';

abstract class ForgotPasswordVerificationEvent extends Equatable {
  const ForgotPasswordVerificationEvent();

  @override
  List<Object> get props => [];
}

class VerificationCodeUpdated extends ForgotPasswordVerificationEvent {
  final String verificationCode;
  const VerificationCodeUpdated(this.verificationCode);

  @override
  List<Object> get props => [verificationCode];
}

class PasswordUpdated extends ForgotPasswordVerificationEvent {
  final String password;
  const PasswordUpdated(this.password);

  @override
  List<Object> get props => [password];
}

class VerificationCodeSubmitted extends ForgotPasswordVerificationEvent {}
