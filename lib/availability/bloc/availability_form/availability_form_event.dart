part of 'availability_form_bloc.dart';

abstract class AvailabilityFormEvent extends Equatable {
  const AvailabilityFormEvent();

  @override
  List<Object> get props => [];
}

class DateUpdated extends AvailabilityFormEvent {
  final String date;
  const DateUpdated(this.date);

  @override
  List<Object> get props => [date];
}

class StartTimeUpdated extends AvailabilityFormEvent {
  final String startTime;
  const StartTimeUpdated(this.startTime);

  @override
  List<Object> get props => [startTime];
}

class EndTimeUpdated extends AvailabilityFormEvent {
  final String endTime;
  const EndTimeUpdated(this.endTime);

  @override
  List<Object> get props => [endTime];
}

class AvailabilityTypeUpdated extends AvailabilityFormEvent {
  final AvailabilityType availabilityType;
  const AvailabilityTypeUpdated(this.availabilityType);

  @override
  List<Object> get props => [availabilityType];
}

class RepeatToggled extends AvailabilityFormEvent {
  const RepeatToggled();
}

class RepeatsEveryUpdated extends AvailabilityFormEvent {
  final RepeatType repeatsEvery;
  const RepeatsEveryUpdated(this.repeatsEvery);

  @override
  List<Object> get props => [repeatsEvery];
}

class RepeatEndDateUpdated extends AvailabilityFormEvent {
  final String repeatEndDate;
  const RepeatEndDateUpdated(this.repeatEndDate);

  @override
  List<Object> get props => [repeatEndDate];
}

class WhoCanSeeUpdated extends AvailabilityFormEvent {
  final WhoCanSeeAvailability whoCanSee;
  const WhoCanSeeUpdated(this.whoCanSee);

  @override
  List<Object> get props => [whoCanSee];
}

class AvailabilityFormSubmitted extends AvailabilityFormEvent {
  const AvailabilityFormSubmitted();
}
