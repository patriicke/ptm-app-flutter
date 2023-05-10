import 'package:formz/formz.dart';

enum AboutValidationError { empty, maxLimit }

class About extends FormzInput<String, AboutValidationError> {
  const About.pure() : super.pure('');
  const About.dirty([String value = '']) : super.dirty(value);

  @override
  AboutValidationError validator(String value) {
    return null;
  }

  String errorText() {
    return null;
  }
}
