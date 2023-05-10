import 'package:formz/formz.dart';

enum SubjectGradeValidationError { empty }

class SubjectGrade extends FormzInput<String, SubjectGradeValidationError> {
  const SubjectGrade.pure() : super.pure('');
  const SubjectGrade.dirty([String value = '']) : super.dirty(value);

  @override
  SubjectGradeValidationError validator(String value) {
    return null;
    // return value?.isNotEmpty == true ? null : SubjectGradeValidationError.empty;
  }
}
