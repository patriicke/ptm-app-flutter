part of 'profile_completion_bloc.dart';

class ProfileCompletionState extends Equatable {
  const ProfileCompletionState({
    this.status = FormzStatus.pure,
    this.profilePhoto = const ProfilePhoto.pure(),
    this.gender = const Gender.pure(),
    this.dateOfBirth = const DateOfBirth.pure(),
    this.error,
  });

  final FormzStatus status;
  final ProfilePhoto profilePhoto;
  final Gender gender;
  final DateOfBirth dateOfBirth;
  final String error;

  ProfileCompletionState copyWith({
    FormzStatus status,
    ProfilePhoto profilePhoto,
    Gender gender,
    DateOfBirth dateOfBirth,
    String error,
  }) {
    return ProfileCompletionState(
      status: status ?? this.status,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        status,
        profilePhoto,
        gender,
        dateOfBirth,
        error,
      ];
}
