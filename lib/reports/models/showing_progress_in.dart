import 'package:formz/formz.dart';

enum ShowingProgressInValidationError { empty }

class ShowingProgressIn
    extends FormzInput<String, ShowingProgressInValidationError> {
  const ShowingProgressIn.pure() : super.pure('');
  const ShowingProgressIn.dirty([String value = '']) : super.dirty(value);

  @override
  ShowingProgressInValidationError validator(String value) {
    return value?.isNotEmpty == true
        ? null
        : ShowingProgressInValidationError.empty;
  }
}
