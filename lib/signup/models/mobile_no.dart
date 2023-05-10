import 'package:formz/formz.dart';

enum MobileNoValidationError { empty, invalid }

class MobileNo extends FormzInput<String, MobileNoValidationError> {
  const MobileNo.pure() : super.pure('');
  const MobileNo.dirty([String value = '']) : super.dirty(value);

  @override
  MobileNoValidationError validator(String value) {
    final isAlphanumeric =
        RegExp(r'^(?!\s*$)[a-zA-Z0-9- ]{1,20}$').hasMatch(value);
    final isNumeric = RegExp(r'^[0-9]+$').hasMatch(value);

    if (value?.isNotEmpty == true && isNumeric)
      return null;
    else if (isAlphanumeric)
      return MobileNoValidationError.invalid;
    else
      return MobileNoValidationError.empty;
  }

  String errorText() {
    if (this.invalid) {
      switch (this.error) {
        case MobileNoValidationError.empty:
          return 'Mobile number is required';
        case MobileNoValidationError.invalid:
          return 'Invalid number';
      }
    }
    return null;
  }
}
