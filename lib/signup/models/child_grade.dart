import 'package:formz/formz.dart';

enum ChildGradeValidationError { empty }

class ChildGrade extends FormzInput<String, ChildGradeValidationError> {
  const ChildGrade.pure() : super.pure('');
  const ChildGrade.dirty([String value = '']) : super.dirty(value);

  @override
  ChildGradeValidationError validator(String value) {
    return null;
  }
}
