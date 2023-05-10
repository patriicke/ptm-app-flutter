import 'package:formz/formz.dart';

enum DateOfBirthValidationError { empty }

class DateOfBirth extends FormzInput<String, DateOfBirthValidationError> {
  const DateOfBirth.pure() : super.pure('');
  const DateOfBirth.dirty([String value = '']) : super.dirty(value);

  @override
  DateOfBirthValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : DateOfBirthValidationError.empty;
  }

  String errorText() {
    if (this.invalid) {
      switch (this.error) {
        case DateOfBirthValidationError.empty:
          return 'Please select your date of birth';
      }
    }
    return null;
  }
}
