import 'package:formz/formz.dart';

enum FullNameValidationError { empty }

class FullName extends FormzInput<String, FullNameValidationError> {
  const FullName.pure() : super.pure('');
  const FullName.dirty([String value = '']) : super.dirty(value);

  @override
  FullNameValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : FullNameValidationError.empty;
  }

  String errorText() {
    if (this.invalid) {
      switch (this.error) {
        case FullNameValidationError.empty:
          return 'This is required';
      }
    }
    return null;
  }
}
