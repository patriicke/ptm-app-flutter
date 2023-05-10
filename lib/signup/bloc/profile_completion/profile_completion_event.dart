part of 'profile_completion_bloc.dart';

abstract class ProfileCompletionEvent extends Equatable {
  const ProfileCompletionEvent();

  @override
  List<Object> get props => [];
}

class ProfileCompletionStarted extends ProfileCompletionEvent {
  const ProfileCompletionStarted();
}

class ProfilePhotoUpdated extends ProfileCompletionEvent {
  const ProfilePhotoUpdated(this.profilePhoto);
  final String profilePhoto;

  @override
  List<Object> get props => [profilePhoto];
}

class GenderUpdated extends ProfileCompletionEvent {
  const GenderUpdated(this.gender);
  final GenderValue gender;

  @override
  List<Object> get props => [gender];
}

class DateOfBirthUpdated extends ProfileCompletionEvent {
  const DateOfBirthUpdated(this.dateOfBirth);
  final String dateOfBirth;

  @override
  List<Object> get props => [dateOfBirth];
}

class ProfileCompletionSubmitted extends ProfileCompletionEvent {
  const ProfileCompletionSubmitted();
}
