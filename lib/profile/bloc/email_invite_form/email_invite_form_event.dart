part of 'email_invite_form_bloc.dart';

abstract class EmailInviteFormEvent extends Equatable {
  const EmailInviteFormEvent();

  @override
  List<Object> get props => [];
}

class EmailUpdated extends EmailInviteFormEvent {
  final String email;
  const EmailUpdated(this.email);

  @override
  List<Object> get props => [email];
}

class EmailInviteFormSubmitted extends EmailInviteFormEvent {
  const EmailInviteFormSubmitted();
}
