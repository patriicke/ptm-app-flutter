part of 'tell_us_more_bloc.dart';

abstract class TellUsMoreEvent extends Equatable {
  const TellUsMoreEvent();

  @override
  List<Object> get props => [];
}

class TellUsMoreLoaded extends TellUsMoreEvent {
  const TellUsMoreLoaded();
}

class SchoolNameUpdated extends TellUsMoreEvent {
  const SchoolNameUpdated(this.schoolName);
  final String schoolName;

  @override
  List<Object> get props => [schoolName];
}

class SchoolSearchRequested extends TellUsMoreEvent {
  const SchoolSearchRequested();
}

class SchoolSelected extends TellUsMoreEvent {
  final String selectedSchoolId;
  const SchoolSelected(this.selectedSchoolId);

  @override
  List<Object> get props => [selectedSchoolId];
}

class SchoolStateUpdated extends TellUsMoreEvent {
  const SchoolStateUpdated(this.schoolState);
  final String schoolState;

  @override
  List<Object> get props => [schoolState];
}

class SchoolCityUpdated extends TellUsMoreEvent {
  const SchoolCityUpdated(this.schoolCity);
  final String schoolCity;

  @override
  List<Object> get props => [schoolCity];
}

class SchoolZipCodeUpdated extends TellUsMoreEvent {
  const SchoolZipCodeUpdated(this.schoolZipCode);
  final String schoolZipCode;

  @override
  List<Object> get props => [schoolZipCode];
}

class TellUsMoreSubmitted extends TellUsMoreEvent {
  const TellUsMoreSubmitted();
}
