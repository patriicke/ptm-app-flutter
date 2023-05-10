import 'package:formz/formz.dart';

enum SchoolStateValidationError { notSelected }

class SchoolState extends FormzInput<String, SchoolStateValidationError> {
  const SchoolState.pure() : super.pure('');
  const SchoolState.dirty([String value = '']) : super.dirty(value);

  @override
  SchoolStateValidationError validator(String value) {
    return null;
  }
}
