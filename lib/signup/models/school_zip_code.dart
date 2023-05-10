import 'package:formz/formz.dart';

enum SchoolZipCodeValidationError { empty }

class SchoolZipCode extends FormzInput<String, SchoolZipCodeValidationError> {
  const SchoolZipCode.pure() : super.pure('');
  const SchoolZipCode.dirty([String value = '']) : super.dirty(value);

  @override
  SchoolZipCodeValidationError validator(String value) {
    return null;
  }
}
