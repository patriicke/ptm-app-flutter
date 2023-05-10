import 'package:formz/formz.dart';

enum GenderValue { male, female, other, none }

enum GenderValidationError { notSelected, invalid }

class Gender extends FormzInput<GenderValue, GenderValidationError> {
  const Gender.pure() : super.pure(GenderValue.none);
  const Gender.dirty([GenderValue value = GenderValue.none])
      : super.dirty(value);

  @override
  GenderValidationError validator(GenderValue value) {
    if (value == GenderValue.none)
      return GenderValidationError.notSelected;
    else if (value != GenderValue.male &&
        value != GenderValue.female &&
        value != GenderValue.other) return GenderValidationError.invalid;
  }

  String errorText() {
    if (this.invalid) {
      switch (this.error) {
        case GenderValidationError.notSelected:
          return 'Please select gender';
        case GenderValidationError.invalid:
          return 'Invalid selection';
          break;
      }
    }
    return null;
  }
}
