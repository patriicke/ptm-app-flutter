part of 'verification_bloc.dart';

class VerificationState extends Equatable {
  const VerificationState({
    this.status = FormzStatus.pure,
    this.emailAddress,
    this.phoneNumber,
    this.verificationCode = const VerificationCode.pure(),
    this.error,
  });

  final FormzStatus status;
  final String emailAddress;
  final String phoneNumber;
  final VerificationCode verificationCode;
  final String error;

  VerificationState copyWith({
    FormzStatus status,
    String emailAddress,
    String phoneNumber,
    VerificationCode verificationCode,
    String error,
  }) {
    return VerificationState(
        status: status ?? this.status,
        emailAddress: emailAddress ?? this.emailAddress,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        verificationCode: verificationCode ?? this.verificationCode,
        error: error ?? this.error);
  }

  @override
  List<Object> get props => [
    status,
    emailAddress,
    phoneNumber,
    verificationCode,
    error,
  ];
}
