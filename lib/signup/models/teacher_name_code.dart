import 'package:formz/formz.dart';

enum TeacherNameCodeValidationError { empty }

class TeacherNameCode
    extends FormzInput<String, TeacherNameCodeValidationError> {
  const TeacherNameCode.pure() : super.pure('');
  const TeacherNameCode.dirty([String value = '']) : super.dirty(value);

  @override
  TeacherNameCodeValidationError validator(String value) {
    return null;
  }
}
