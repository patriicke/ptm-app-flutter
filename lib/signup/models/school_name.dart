import 'package:formz/formz.dart';

enum SchoolNameValidationError { empty }

class SchoolName extends FormzInput<String, SchoolNameValidationError> {
  const SchoolName.pure() : super.pure('');
  const SchoolName.dirty([String value = '']) : super.dirty(value);

  @override
  SchoolNameValidationError validator(String value) {
    return null;
  }
}
