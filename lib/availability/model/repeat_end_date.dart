import 'package:formz/formz.dart';

enum RepeatEndDateValidationError { empty }

class RepeatEndDate extends FormzInput<String, RepeatEndDateValidationError> {
  const RepeatEndDate.pure() : super.pure('');
  const RepeatEndDate.dirty([String value = '']) : super.dirty(value);

  @override
  RepeatEndDateValidationError validator(String value) {
    return null;
  }
}
