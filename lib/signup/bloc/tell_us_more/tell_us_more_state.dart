part of 'tell_us_more_bloc.dart';

abstract class TellUsMoreState extends Equatable {
  const TellUsMoreState();

  @override
  List<Object> get props => [];
}

class TellUsMoreLoadInProgress extends TellUsMoreState {}

class TellUsMoreLoadSuccess extends TellUsMoreState {
  final FormzStatus status;
  final SchoolName schoolName;
  final SchoolState schoolState;
  final SchoolCity schoolCity;
  final SchoolZipCode schoolZipCode;
  final String error;

  final List<CityDto> cities;

  TellUsMoreLoadSuccess({
    this.status = FormzStatus.pure,
    this.schoolName = const SchoolName.pure(),
    this.schoolState = const SchoolState.pure(),
    this.schoolCity = const SchoolCity.pure(),
    this.schoolZipCode = const SchoolZipCode.pure(),
    this.error,
    this.cities = const [],
  });

  TellUsMoreLoadSuccess copyWith({
    FormzStatus status,
    SchoolName schoolName,
    SchoolState schoolState,
    SchoolCity schoolCity,
    SchoolZipCode schoolZipCode,
    String error,
    List<CityDto> cities,
  }) {
    return TellUsMoreLoadSuccess(
      status: status ?? this.status,
      schoolName: schoolName ?? this.schoolName,
      schoolState: schoolState ?? this.schoolState,
      schoolCity: schoolCity ?? this.schoolCity,
      schoolZipCode: schoolZipCode ?? this.schoolZipCode,
      error: error ?? this.error,
      cities: cities ?? this.cities,
    );
  }

  @override
  List<Object> get props => [
        status,
        schoolName,
        schoolState,
        schoolCity,
        schoolZipCode,
        error,
        cities,
      ];
}

class TellUsMoreLoadFailure extends TellUsMoreState {
  final String error;
  TellUsMoreLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
