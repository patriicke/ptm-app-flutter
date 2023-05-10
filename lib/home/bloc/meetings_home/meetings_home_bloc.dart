import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:meetings/consts.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';
import 'package:flinq/flinq.dart';

part 'meetings_home_event.dart';
part 'meetings_home_state.dart';

class MeetingsHomeBloc extends Bloc<MeetingsHomeEvent, MeetingsHomeState> {
  MeetingsHomeBloc({
    @required MeetingsRepository meetingsRepository,
    @required AuthenticationRepository authenticationRepository,
  })  : assert(meetingsRepository != null),
        assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        _meetingsRepository = meetingsRepository,
        super(MeetingsLoadInProgress());

  final MeetingsRepository _meetingsRepository;
  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<MeetingsHomeState> mapEventToState(
    MeetingsHomeEvent event,
  ) async* {
    if (event is MeetingsLoaded) {
      yield* _mapMeetingsLoadedToState();
    } else if (event is MeetingStatusToggled) {
      yield* _mapMeetingStatusToggledToState(event);
    } else if (event is MeetingEntered) {
      await _meetingsRepository.registerMeetingEntry(
          _authenticationRepository.authKey,
          event.meetingId,
          _authenticationRepository.currentUser.id,
          DateTime.now().toString());
    }
  }

  Stream<MeetingsHomeState> _mapMeetingsLoadedToState() async* {
    yield MeetingsLoadInProgress();
    try {
      var authKey = _authenticationRepository.authKey;
      final meetings = await this._meetingsRepository.getMeetings(authKey);
      var events = _generateMeetingEventList(meetings);
      yield MeetingsLoadSuccess(
        meetings: meetings,
        meetingEvents: events,
      );
    } catch (e) {
      yield MeetingsLoadFailure(e.toString());
    }
  }

  Stream<MeetingsHomeState> _mapMeetingStatusToggledToState(
    MeetingStatusToggled event,
  ) async* {
    if (state is MeetingsLoadSuccess) {
      var meetingToUpdate = (state as MeetingsLoadSuccess)
          .meetings
          .where((meeting) => meeting.id == event.meetingId)
          .first;

      if (meetingToUpdate != null) {
        // newStatus (0) = Rejected, newStatus(1) = Accepted
        // If user is already going, then new status must be rejected
        var newStatus = meetingToUpdate.meetingStatus == 'going' ? 0 : 1;
        var authKey = _authenticationRepository.authKey;
        var meetingId = meetingToUpdate.id;
        var userId = _authenticationRepository.currentUser.id;
        try {
          var updatedMeeting = await _meetingsRepository.updateMeetingStatus(
              authKey, meetingId, userId, newStatus);
          final List<Meeting> updatedMeetings =
              (state as MeetingsLoadSuccess).meetings.map((meeting) {
            return meeting.id == event.meetingId ? updatedMeeting : meeting;
          }).toList();
          yield MeetingsLoadSuccess(meetings: updatedMeetings);
        } catch (e) {
          yield MeetingsLoadFailure(e.toString());
        }
      }
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

  EventList<Event> _generateMeetingEventList(List<Meeting> meetings) {
    var events = new EventList<Event>(events: {});
    var meetingDates = meetings.map((e) => e.meetingStartsOn).distinct;

    for (var date in meetingDates) {
      try {
        var parsedDate = DateTime.parse(date);
        var parsedDateLiteral =
            DateTime(parsedDate.year, parsedDate.month, parsedDate.day);
        var dateMeetings = meetings
            .where((meeting) => meeting.meetingStartsOn == date)
            .toList();

        var dateEvents = dateMeetings.map(
          (meeting) {
            var parsedMeetingDate = DateTime.parse(meeting.meetingStartsOn);
            var parsedMeetingDateLiteral = DateTime(parsedMeetingDate.year,
                parsedMeetingDate.month, parsedMeetingDate.day);
            return new Event(
              date: parsedMeetingDateLiteral,
              title: meeting.title,
              dot: Container(
                margin: EdgeInsets.symmetric(horizontal: 1.0),
                color: PrimaryColor,
                height: 4.0,
                width: 4.0,
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
