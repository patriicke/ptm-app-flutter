import 'package:formz/formz.dart';

enum MeetingTitleValitationError { empty }

class MeetingTitle extends FormzInput<String, MeetingTitleValitationError> {
  const MeetingTitle.pure() : super.pure('');
  const MeetingTitle.dirty([String value = '']) : super.dirty(value);

  @override
  MeetingTitleValitationError validator(String value) {
    return value?.isNotEmpty == true ? null : MeetingTitleValitationError.empty;
  }
}
