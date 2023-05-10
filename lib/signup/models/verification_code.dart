import 'package:formz/formz.dart';

enum VerificationCodeValidationError { empty }

class VerificationCode
    extends FormzInput<String, VerificationCodeValidationError> {
  const VerificationCode.pure() : super.pure('');
  const VerificationCode.dirty([String value = '']) : super.dirty(value);

  @override
  VerificationCodeValidationError validator(String value) {
    return null;
  }
}
