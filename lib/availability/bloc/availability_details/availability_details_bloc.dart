import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:meetings/consts.dart';
import 'package:meetings/profile/bloc/user_profile/user_profile_bloc.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';
import 'package:flinq/flinq.dart';

part 'availability_details_event.dart';
part 'availability_details_state.dart';

class AvailabilityDetailsBloc
    extends Bloc<AvailabilityDetailsEvent, AvailabilityDetailsState> {
  AvailabilityDetailsBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(AvailabilityDetailsLoadingInProgress());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<AvailabilityDetailsState> mapEventToState(
    AvailabilityDetailsEvent event,
  ) async* {
    if (event is AvailabilityDetailsLoaded) {
      yield* _mapAvailabilityDetailsLoadedToState(event);
    }
  }

  Stream<AvailabilityDetailsState> _mapAvailabilityDetailsLoadedToState(
      AvailabilityDetailsLoaded event) async* {
    yield AvailabilityDetailsLoadingInProgress();
    try {
      var authKey = _authenticationRepository.authKey;
      var userId = _authenticationRepository.currentUser.id;
      var teacherApi = TeacherApi();
      var response = await teacherApi.getTeacherAvailability(
          authKey, userId, event.whoCanSeeFilter.toString());

      if (response.apiResponseMessage.code != 200) {
        log('Exception when calling TeacherApi->getTeacherAvailability. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
        throw Exception(
            'Exception when calling TeacherApi->getTeacherAvailability. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
      }
      yield AvailabilityDetailsLoadSuccess(
        response.data,
        event.whoCanSeeFilter == null
            ? WhoCanSeeAvailability.justMe
            : event.whoCanSeeFilter,
        availabilityEvents: _generateMeetingEventList(response.data),
      );
    } catch (e) {
      yield AvailabilityDetailsLoadFailure(e.toString());
    }
  }

  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _generateMeetingEventList(
      List<TeacherAvailability> teacherAvailability) {
    var events = new EventList<Event>(events: {});
    var availabilityDays =
        teacherAvailability.map((e) => e.availabilityDate).distinct;

    for (var day in availabilityDays) {
      try {
        var parsedDate = DateTime.parse(day);
        var parsedDateLiteral =
            DateTime(parsedDate.year, parsedDate.month, parsedDate.day);
        var dateMeetings = teacherAvailability
            .where((availabilityDay) => availabilityDay.availabilityDate == day)
            .toList();

        var dateEvents = dateMeetings.map(
          (availabilityDay) {
            var parsedMeetingDate =
                DateTime.parse(availabilityDay.availabilityDate);
            var parsedMeetingDateLiteral = DateTime(parsedMeetingDate.year,
                parsedMeetingDate.month, parsedMeetingDate.day);
            return new Event(
              date: parsedMeetingDateLiteral,
              title: availabilityDay.availabilityType,
              dot: Container(
                margin: EdgeInsets.symmetric(horizontal: 1.0),
                color: PrimaryColor,
                height: 5.0,
                width: 5.0,
              ),
              icon: _eventIcon,
            );
          },
        ).toList();

        events.addAll(parsedDateLiteral, dateEvents);
      } catch (e) {
        log(e.toString());
        continue;
      }
    }

    return events;
  }
}
