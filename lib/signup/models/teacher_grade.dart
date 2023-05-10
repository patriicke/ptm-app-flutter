import 'package:formz/formz.dart';

enum TeacherSubjectValidationError { empty }

class TeacherSubject extends FormzInput<String, TeacherSubjectValidationError> {
  const TeacherSubject.pure() : super.pure('');
  const TeacherSubject.dirty([String value = '']) : super.dirty(value);

  @override
  TeacherSubjectValidationError validator(String value) {
    return null;
  }
}
