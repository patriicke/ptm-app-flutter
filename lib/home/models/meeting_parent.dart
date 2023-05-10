import 'package:formz/formz.dart';

enum MeetingRecipientValidationError { empty }

class MeetingRecipient
    extends FormzInput<String, MeetingRecipientValidationError> {
  const MeetingRecipient.pure() : super.pure('');
  const MeetingRecipient.dirty([String value = '']) : super.dirty(value);

  @override
  MeetingRecipientValidationError validator(String value) {
    return null;
  }
}
