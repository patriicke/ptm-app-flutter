import 'package:formz/formz.dart';

enum ProfilePhotoValidationError { empty }

class ProfilePhoto extends FormzInput<String, ProfilePhotoValidationError> {
  const ProfilePhoto.pure() : super.pure('');
  const ProfilePhoto.dirty([String value = '']) : super.dirty(value);

  @override
  ProfilePhotoValidationError validator(String value) {
    return null;
  }

  String errorText() {
    return null;
  }
}
