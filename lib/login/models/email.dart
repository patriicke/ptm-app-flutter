import 'package:email_validator/email_validator.dart';
import 'package:formz/formz.dart';

enum EmailValidationError { empty, invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError validator(String value) {
    if (value?.isEmpty == true)
      return EmailValidationError.empty;
    else if (!EmailValidator.validate(value))
      return EmailValidationError.invalid;
    else
      return null;
  }

  String errorText() {
    if (this.invalid) {
      switch (this.error) {
        case EmailValidationError.empty:
          return 'This is required';
        case EmailValidationError.invalid:
          return 'Invalid email';
      }
    }
    return null;
  }
}
