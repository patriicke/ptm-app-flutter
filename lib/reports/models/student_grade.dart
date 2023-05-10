import 'package:formz/formz.dart';

enum StudentGradeValidationError { empty }

class StudentGrade extends FormzInput<String, StudentGradeValidationError> {
  const StudentGrade.pure() : super.pure('');
  const StudentGrade.dirty([String value = '']) : super.dirty(value);

  @override
  StudentGradeValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : StudentGradeValidationError.empty;
  }
}
