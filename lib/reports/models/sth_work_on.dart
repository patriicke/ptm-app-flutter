import 'package:formz/formz.dart';

enum SomethingToWorkOnValidationError { empty }

class SomethingToWorkOn
    extends FormzInput<String, SomethingToWorkOnValidationError> {
  const SomethingToWorkOn.pure() : super.pure('');
  const SomethingToWorkOn.dirty([String value = '']) : super.dirty(value);

  @override
  SomethingToWorkOnValidationError validator(String value) {
    return value?.isNotEmpty == true
        ? null
        : SomethingToWorkOnValidationError.empty;
  }
}
