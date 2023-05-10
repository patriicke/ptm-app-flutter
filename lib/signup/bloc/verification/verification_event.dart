part of 'verification_bloc.dart';

abstract class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}

class VerificationStarted extends VerificationEvent {
  const VerificationStarted();
}

class VerificationCodeUpdated extends VerificationEvent {
  const VerificationCodeUpdated(this.verificationCode);
  final String verificationCode;

  @override
  List<Object> get props => [verificationCode];
}

class VerificationSubmitted extends VerificationEvent {
  const VerificationSubmitted();
}
