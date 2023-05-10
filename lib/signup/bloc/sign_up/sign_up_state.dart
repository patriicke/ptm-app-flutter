part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.status = FormzStatus.pure,
    this.fullName = const FullName.pure(),
    this.email = const Email.pure(),
    this.mobileNo = const MobileNo.pure(),
    this.password = const Password.pure(),
    this.about = const About.pure(),
    this.signupType = 0,
    this.signupError,
  });

  final FormzStatus status;
  final FullName fullName;
  final Email email;
  final MobileNo mobileNo;
  final Password password;
  final About about;
  final int signupType;
  final String signupError;

  SignUpState copyWith({
    FormzStatus status,
    FullName fullName,
    Email email,
    MobileNo mobileNo,
    Password password,
    About about,
    int signupType,
    String signupError,
  }) {
    return SignUpState(
      status: status ?? this.status,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      mobileNo: mobileNo ?? this.mobileNo,
      password: password ?? this.password,
      about: about ?? this.about,
      signupType: signupType ?? this.signupType,
      signupError: signupError ?? this.signupError,
    );
  }

  @override
  List<Object> get props => [
    status,
    fullName,
    email,
    mobileNo,
    password,
    about,
    signupType,
    signupError,
  ];
}
