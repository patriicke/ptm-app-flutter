part of 'availability_details_bloc.dart';

abstract class AvailabilityDetailsEvent extends Equatable {
  const AvailabilityDetailsEvent();

  @override
  List<Object> get props => [];
}

class AvailabilityDetailsLoaded extends AvailabilityDetailsEvent {
  final WhoCanSeeAvailability whoCanSeeFilter;

  const AvailabilityDetailsLoaded({this.whoCanSeeFilter});

  @override
  List<Object> get props => [whoCanSeeFilter];
}
