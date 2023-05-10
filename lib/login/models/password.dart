import 'package:formz/formz.dart';

enum PasswordValidationError { empty }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : PasswordValidationError.empty;
  }

  String errorText() {
    if (this.invalid) {
      switch (this.error) {
        case PasswordValidationError.empty:
          return 'Password is required';
      }
    }
    return null;
  }
}
