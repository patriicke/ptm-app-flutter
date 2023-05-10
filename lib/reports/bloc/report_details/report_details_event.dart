part of 'report_details_bloc.dart';

abstract class ReportDetailsEvent extends Equatable {
  const ReportDetailsEvent();

  @override
  List<Object> get props => [];
}

class ReportDetailsLoaded extends ReportDetailsEvent {
  const ReportDetailsLoaded();
}

class ParentRatingUpdated extends ReportDetailsEvent {
  final int parentRating;
  const ParentRatingUpdated(this.parentRating);

  @override
  List<Object> get props => [parentRating];
}

class ParentCommentsUpdated extends ReportDetailsEvent {
  final String parentComments;
  const ParentCommentsUpdated(this.parentComments);

  @override
  List<Object> get props => [parentComments];
}

class ParentFeedbackSubmitted extends ReportDetailsEvent {
  const ParentFeedbackSubmitted();
}
