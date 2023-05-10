import 'package:formz/formz.dart';

enum FeedbackRatingValidationError { empty }

class FeedbackRating extends FormzInput<int, FeedbackRatingValidationError> {
  const FeedbackRating.pure() : super.pure(0);
  const FeedbackRating.dirty(int value) : super.dirty(value);

  @override
  FeedbackRatingValidationError validator(int value) {
    return value != null ? null : FeedbackRatingValidationError.empty;
  }
}
