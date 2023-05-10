import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum AvailabilitySetting { unavailable, availableForMeetings }
enum RepeatPeriod { day, week, month, year }
enum WhoCanSchedule { everyone, justMe }

class AvailabilityDay extends Equatable {
  const AvailabilityDay({
    this.date,
    this.startTime,
    this.endTime,
    this.availabilitySetting,
    this.repeat,
    this.repeatPeriod,
    this.repeatEndsOn,
    this.whoCanSchedule,
  });

  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final AvailabilitySetting availabilitySetting;
  final bool repeat;
  final RepeatPeriod repeatPeriod;
  final DateTime repeatEndsOn;
  final WhoCanSchedule whoCanSchedule;

  AvailabilityDay copyWith({
    DateTime date,
    TimeOfDay startTime,
    TimeOfDay endTime,
    AvailabilitySetting availabilitySetting,
    bool repeat,
    RepeatPeriod repeatPeriod,
    DateTime repeatEndsOn,
    WhoCanSchedule whoCanSchedule,
  }) {
    return AvailabilityDay(
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      availabilitySetting: availabilitySetting ?? this.availabilitySetting,
      repeat: repeat ?? this.repeat,
      repeatPeriod: repeatPeriod ?? this.repeatPeriod,
      repeatEndsOn: repeatEndsOn ?? this.repeatEndsOn,
      whoCanSchedule: whoCanSchedule ?? this.whoCanSchedule,
    );
  }

  @override
  List<Object> get props => [
        date,
        availabilitySetting,
        repeat,
        repeatPeriod,
        repeatEndsOn,
        whoCanSchedule,
      ];
}
