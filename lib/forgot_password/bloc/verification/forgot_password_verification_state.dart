part of 'forgot_password_verification_bloc.dart';

class ForgotPasswordVerificationState extends Equatable {
  final VerificationCode verificationCode;
  final Password password;
  final FormzStatus status;
  final String error;
  const ForgotPasswordVerificationState({
    this.verificationCode = const VerificationCode.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.error,
  });

  ForgotPasswordVerificationState copyWith({
    VerificationCode verificationCode,
    Password password,
    FormzStatus status,
    String error,
  }) {
    return ForgotPasswordVerificationState(
      verificationCode: verificationCode ?? this.verificationCode,
      password: password ?? this.password,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [verificationCode, password, status, error];
}
