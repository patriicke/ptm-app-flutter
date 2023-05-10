part of 'email_submission_bloc.dart';

abstract class EmailSubmissionEvent extends Equatable {
  const EmailSubmissionEvent();

  @override
  List<Object> get props => [];
}

class EmailUpdated extends EmailSubmissionEvent {
  final String email;
  const EmailUpdated(this.email);

  @override
  List<Object> get props => [email];
}
/*class PhoneNoUpdated extends EmailSubmissionEvent {
  final String phoneNo;
  const PhoneNoUpdated(this.phoneNo);

  @override
  List<Object> get props => [phoneNo];
}*/


class EmailSubmissionSubmitted extends EmailSubmissionEvent {}
