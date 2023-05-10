import 'package:formz/formz.dart';

enum ChildNameValidationError { empty }

class ChildName extends FormzInput<String, ChildNameValidationError> {
  const ChildName.pure() : super.pure('');
  const ChildName.dirty([String value = '']) : super.dirty(value);

  @override
  ChildNameValidationError validator(String value) {
    return null;
  }
}
