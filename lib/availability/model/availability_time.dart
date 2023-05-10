import 'package:formz/formz.dart';

enum AvailabilityTimeValidationError { empty }

class AvailabilityTime
    extends FormzInput<String, AvailabilityTimeValidationError> {
  const AvailabilityTime.pure() : super.pure('');
  const AvailabilityTime.dirty([String value = '']) : super.dirty(value);

  @override
  AvailabilityTimeValidationError validator(String value) {
    return value?.isNotEmpty == true
        ? null
        : AvailabilityTimeValidationError.empty;
  }
}
