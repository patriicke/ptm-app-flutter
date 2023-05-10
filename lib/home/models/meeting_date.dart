import 'package:formz/formz.dart';

enum MeetingDateValidationError { empty }

class MeetingDate extends FormzInput<String, MeetingDateValidationError> {
  const MeetingDate.pure() : super.pure('');
  const MeetingDate.dirty([String value = '']) : super.dirty(value);

  @override
  MeetingDateValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : MeetingDateValidationError.empty;
  }
}
