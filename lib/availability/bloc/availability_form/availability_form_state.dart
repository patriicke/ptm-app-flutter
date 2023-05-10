part of 'availability_form_bloc.dart';

enum AvailabilityType { unavailable, availableForMeetings }
enum RepeatType { day, week, month, year }

class AvailabilityFormState extends Equatable {
  final FormzStatus status;
  final AvailabilityDate date;
  final AvailabilityTime startTime;
  final AvailabilityTime endTime;
  final AvailabilityType availabilityType;
  final bool repeats;
  final RepeatType repeatsEvery;
  final RepeatEndDate repeatEndDate;
  final WhoCanSeeAvailability whoCanSee;
  final String error;

  const AvailabilityFormState({
    this.status = FormzStatus.pure,
    this.date = const AvailabilityDate.pure(),
    this.startTime = const AvailabilityTime.pure(),
    this.endTime = const AvailabilityTime.pure(),
    this.availabilityType = AvailabilityType.unavailable,
    this.repeats = false,
    this.repeatsEvery = RepeatType.day,
    this.repeatEndDate = const RepeatEndDate.pure(),
    this.whoCanSee = WhoCanSeeAvailability.justMe,
    this.error,
  });

  AvailabilityFormState copyWith({
    FormzStatus status,
    AvailabilityDate date,
    AvailabilityTime startTime,
    AvailabilityTime endTime,
    AvailabilityType availabilityType,
    bool repeats,
    RepeatType repeatsEvery,
    RepeatEndDate repeatEndDate,
    WhoCanSeeAvailability whoCanSee,
    String error,
  }) {
    return AvailabilityFormState(
      status: status ?? this.status,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      availabilityType: availabilityType ?? this.availabilityType,
      repeats: repeats ?? this.repeats,
      repeatsEvery: repeatsEvery ?? this.repeatsEvery,
      repeatEndDate: repeatEndDate ?? this.repeatEndDate,
      whoCanSee: whoCanSee ?? this.whoCanSee,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        status,
        date,
        startTime,
        endTime,
        availabilityType,
        repeats,
        repeatsEvery,
        repeatEndDate,
        whoCanSee,
        error,
      ];
}
