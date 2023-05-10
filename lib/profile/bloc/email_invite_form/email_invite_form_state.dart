part of 'email_invite_form_bloc.dart';

class EmailInviteFormState extends Equatable {
  final Email email;
  final FormzStatus status;
  final String error;

  const EmailInviteFormState({
    this.email = const Email.pure(),
    this.status = FormzStatus.pure,
    this.error,
  });

  EmailInviteFormState copyWith({
    Email email,
    FormzStatus status,
    String error,
  }) {
    return EmailInviteFormState(
      email: email ?? this.email,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        email,
        status,
        error,
      ];
}
