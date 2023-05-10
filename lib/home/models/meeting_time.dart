import 'package:formz/formz.dart';

enum MeetingTimeValidationError { empty }

class MeetingTime extends FormzInput<String, MeetingTimeValidationError> {
  const MeetingTime.pure() : super.pure('');
  const MeetingTime.dirty([String value = '']) : super.dirty(value);

  @override
  MeetingTimeValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : MeetingTimeValidationError.empty;
  }
}
