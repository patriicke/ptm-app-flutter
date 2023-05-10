import 'package:formz/formz.dart';

enum SchoolCityValidationError { notSelected }

class SchoolCity extends FormzInput<String, SchoolCityValidationError> {
  const SchoolCity.pure() : super.pure('');
  const SchoolCity.dirty([String value = '']) : super.dirty(value);

  @override
  SchoolCityValidationError validator(String value) {
    return null;
  }
}
