part of 'edit_details_bloc.dart';

class EditDetailsState extends Equatable {
  final FormzStatus status;
  final Email email;
  final MobileNo phoneNo;
  final Password password;
  final String error;

  const EditDetailsState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.phoneNo = const MobileNo.pure(),
    this.password = const Password.pure(),
    this.error,
  });

  EditDetailsState copyWith({
    FormzStatus status,
    Email email,
    MobileNo phoneNo,
    Password password,
    String error,
  }) {
    return EditDetailsState(
      status: status ?? this.status,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      password: password ?? this.password,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        status,
        email,
        phoneNo,
        password,
        error,
      ];

  @override
  String toString() =>
      'EditDetailsState { status: ${status.toString()}, email: ${email.value.toString()}, password: ${password.value.toString()}, phoneNo: ${phoneNo.value.toString()}';
}
