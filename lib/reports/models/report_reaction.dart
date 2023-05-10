import 'package:formz/formz.dart';

enum ReportReactionValidationError { empty }

class ReportReaction extends FormzInput<String, ReportReactionValidationError> {
  const ReportReaction.pure() : super.pure('');
  const ReportReaction.dirty([String value = '']) : super.dirty(value);

  @override
  ReportReactionValidationError validator(String value) {
    return value?.isNotEmpty == true
        ? null
        : ReportReactionValidationError.empty;
  }
}
