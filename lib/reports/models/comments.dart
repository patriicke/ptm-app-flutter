import 'package:formz/formz.dart';

enum CommentsValidationError { empty }

class Comments extends FormzInput<String, CommentsValidationError> {
  const Comments.pure() : super.pure('');
  const Comments.dirty([String value = '']) : super.dirty(value);

  @override
  CommentsValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : CommentsValidationError.empty;
  }
}
