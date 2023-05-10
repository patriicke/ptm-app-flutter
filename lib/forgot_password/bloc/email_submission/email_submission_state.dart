part of 'email_submission_bloc.dart';

class EmailSubmissionState extends Equatable {
  final FormzStatus status;
  final Email email;
  //final MobileNo phoneNo;
  final String error;
  final int signupEventId;

  const EmailSubmissionState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    //this.phoneNo = const MobileNo.pure(),
    this.error,
    this.signupEventId,
  });

  EmailSubmissionState copyWith({
    FormzStatus status,
    Email email,
    MobileNo phoneNo,
    String error,
    int signupEventId,
  }) {
    return EmailSubmissionState(
      status: status ?? this.status,
      email: email ?? this.email,
      //phoneNo: phoneNo ?? this.phoneNo,
      error: error ?? this.error,
      signupEventId: signupEventId ?? this.signupEventId,
    );
  }

  @override
  //List<Object> get props => [status, email , phoneNo ,error, signupEventId];
  List<Object> get props => [status, email ,error, signupEventId];
}

