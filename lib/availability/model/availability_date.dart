import 'package:formz/formz.dart';

enum AvailabilityDateValidationError { empty }

class AvailabilityDate
    extends FormzInput<String, AvailabilityDateValidationError> {
  const AvailabilityDate.pure() : super.pure('');
  const AvailabilityDate.dirty([String value = '']) : super.dirty(value);

  @override
  AvailabilityDateValidationError validator(String value) {
    return value?.isNotEmpty == true
        ? null
        : AvailabilityDateValidationError.empty;
  }
}
