import 'package:formz/formz.dart';

enum TextMessageValidationError { empty }

class TextMessage extends FormzInput<String, TextMessageValidationError> {
  const TextMessage.pure() : super.pure('');
  const TextMessage.dirty([String value = '']) : super.dirty(value);

  @override
  TextMessageValidationError validator(value) {
    return value?.isNotEmpty == true ? null : TextMessageValidationError.empty;
  }
}
