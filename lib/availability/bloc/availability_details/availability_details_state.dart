part of 'availability_details_bloc.dart';

abstract class AvailabilityDetailsState extends Equatable {
  const AvailabilityDetailsState();

  @override
  List<Object> get props => [];
}

class AvailabilityDetailsLoadingInProgress extends AvailabilityDetailsState {}

class AvailabilityDetailsLoadSuccess extends AvailabilityDetailsState {
  final List<TeacherAvailability> teacherAvailability;
  final WhoCanSeeAvailability availabilityFilter;
  final EventList<Event> availabilityEvents;

  AvailabilityDetailsLoadSuccess(
    this.teacherAvailability,
    this.availabilityFilter, {
    this.availabilityEvents,
  });

  @override
  List<Object> get props =>
      [teacherAvailability, availabilityFilter, availabilityEvents];
}

class AvailabilityDetailsLoadFailure extends AvailabilityDetailsState {
  final String error;

  AvailabilityDetailsLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
