part of 'edit_details_bloc.dart';

abstract class EditDetailsEvent extends Equatable {
  const EditDetailsEvent();

  @override
  List<Object> get props => [];
}

class EmailUpdated extends EditDetailsEvent {
  final String email;
  const EmailUpdated(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordUpdated extends EditDetailsEvent {
  final String password;
  const PasswordUpdated(this.password);

  @override
  List<Object> get props => [password];
}

class PhoneNoUpdated extends EditDetailsEvent {
  final String phoneNo;
  const PhoneNoUpdated(this.phoneNo);

  @override
  List<Object> get props => [phoneNo];
}

class EditDetailsSubmitted extends EditDetailsEvent {
  const EditDetailsSubmitted();
}
