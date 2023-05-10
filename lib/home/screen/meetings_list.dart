import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
// import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:meetings/blocs/authentication/authentication.dart';
import 'package:meetings/blocs/login_type/login_type_bloc.dart';
import 'package:meetings/consts.dart';
import 'package:meetings/home/bloc/meetings_home/meetings_home_bloc.dart';
import 'package:meetings/availability/screen/availability_details_screen.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';
import 'package:flinq/flinq.dart';

class MeetingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingsHomeBloc, MeetingsHomeState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is MeetingsLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MeetingsLoadSuccess) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _MeetingsCalendar(),
                _MeetingList(),
                const Padding(padding: EdgeInsets.only(top: 90))
              ],
            ),
          );
        } else if (state is MeetingsLoadFailure) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(state.error),
              TextButton(
                onPressed: () {
                  context.bloc<MeetingsHomeBloc>().add(MeetingsLoaded());
                },
                child: Text('Reload'),
              ),
            ],
          );
        }
      },
    );
  }
}

class _MeetingsCalendar extends StatefulWidget {
  _MeetingsCalendar({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MeetingsCalendarState createState() => _MeetingsCalendarState();
}

class _MeetingsCalendarState extends State<_MeetingsCalendar> {
  DateTime _currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String _currentMonth = DateFormat.yMMM().format(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
  DateTime _targetDateTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<DateTime> getDate() {
    return showDatePicker(
        context: context,
        initialDate: _currentDate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        builder: (BuildContext context, Widget child) {
          return Theme(
            child: child,
            data: ThemeData.light(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginTypeBloc, LoginType>(
      builder: (context, loginTypeState) {
        var headerRow = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                final selectedDate = await getDate();
                if (selectedDate != null) {
                  setState(() {
                    _currentDate = selectedDate;
                    _targetDateTime =
                        DateTime(selectedDate.year, selectedDate.month);
                    _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                  });
                }
              },
              child: Row(
                children: [
                  Text(
                    _currentMonth,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: PrimaryColor,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: PrimaryColor,
                    size: 22.0,
                  ),
                ],
              ),
            ),
          ],
        );
        if (loginTypeState == LoginType.teacher) {
          headerRow.children.add(
            GestureDetector(
              child: Text(
                'Set availability',
                style: TextStyle(
                  color: PrimaryColor,
                  fontSize: 14.0,
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(AvailabilityDetailsScreen.route());
              },
            ),
          );
        }
        return BlocBuilder<MeetingsHomeBloc, MeetingsHomeState>(
          builder: (context, state) {
            return Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 22)),
                headerRow,
                const Padding(padding: EdgeInsets.only(top: 31)),
                CalendarCarousel<Event>(
                  onDayPressed: (DateTime date, List<Event> events) {
                    this.setState(() => _currentDate = date);
                  },
                  selectedDayButtonColor: Colors.grey[300],
                  showOnlyCurrentMonthDate: false,
                  weekendTextStyle: TextStyle(
                    color: AccentColor,
                  ),
                  todayButtonColor: Colors.grey[50],
                  todayTextStyle: TextStyle(color: PrimaryColor),
                  weekdayTextStyle: TextStyle(
                    color: PrimaryColor,
                  ),
                  daysTextStyle: TextStyle(
                    color: PrimaryColor,
                  ),
                  thisMonthDayBorderColor: Colors.grey,
                  weekFormat: false,
                  // firstDayOfWeek: 4,
                  markedDatesMap: (state as MeetingsLoadSuccess).meetingEvents,
                  height: 280,
                  selectedDateTime: _currentDate,
                  targetDateTime: _targetDateTime,
                  showHeader: false,
                  onCalendarChanged: (DateTime date) {
                    this.setState(() {
                      log(date.toString());
                      _targetDateTime = date;
                      _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                    });
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _MeetingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingsHomeBloc, MeetingsHomeState>(
      builder: (context, state) {
        final meetings = (state as MeetingsLoadSuccess).meetings;
        var meetingCards = <Widget>[
          Text(
            'Upcoming meetings',
            style: TextStyle(color: PrimaryColor),
          ),
          const Padding(padding: EdgeInsets.only(top: 12)),
        ];
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authState) {
            meetings.forEach((meeting) {
              return meetingCards
                  .add(new _MeetingCard(meeting, authState.user));
            });
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: meetingCards,
            );
          },
        );
      },
    );
  }
}

class _MeetingCard extends StatelessWidget {
  const _MeetingCard(this._meeting, this._currentUser);
  final Meeting _meeting;
  final UserEntity _currentUser;

  _joinMeeting(String room, String subject, String userDisplayName,
      String userEmail) async {
    //   try {
    //     /*FeatureFlag featureFlag = FeatureFlag();
    //     featureFlag.addPeopleEnabled = false;
    //     featureFlag.inviteEnabled = false;*/

    //     Map<FeatureFlagEnum, bool> featureFlags = {
    //       FeatureFlagEnum.ADD_PEOPLE_ENABLED: false,
    //       FeatureFlagEnum.INVITE_ENABLED: false,
    //     };

    //     var options = JitsiMeetingOptions(room: room) // Required, spaces will be trimmed
    //       ..featureFlags.addAll(featureFlags)
    //       ..serverURL = "https://meet.parentteachermobile.com/"
    //       ..subject = subject
    //       ..userDisplayName = userDisplayName
    //       ..userEmail = userEmail
    //       ..audioOnly = true
    //       ..audioMuted = true
    //       ..videoMuted = true;

    //     debugPrint("JitsiMeetingOptions: $options");

    //     //await JitsiMeet.joinMeeting(options, roomNameConstraints: Map());
    //     await JitsiMeet.joinMeeting(
    //       options,
    //         roomNameConstraints: Map(),
    //       listener: JitsiMeetingListener(
    //           onConferenceWillJoin: (message) {
    //             debugPrint("${options.room} will join with message: $message");
    //           },
    //           onConferenceJoined: (message) {
    //             debugPrint("${options.room} joined with message: $message");
    //           },
    //           onConferenceTerminated: (message) {
    //             debugPrint("${options.room} terminated with message: $message");
    //           },
    //           genericListeners: [
    //             JitsiGenericListener(
    //                 eventName: 'readyToClose',
    //                 callback: (dynamic message) {
    //                   debugPrint("readyToClose callback");
    //                 }),
    //           ]),
    //     );
    //   } catch (error) {
    //     debugPrint("error: $error");
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.0, color: PrimaryColor),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: PrimaryColor, width: 5.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              trailing: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: IconButton(
                  icon: _meeting.meetingStatus == 'going'
                      ? Icon(Icons.person, color: AccentColor)
                      : Icon(Icons.person_add_disabled, color: AccentColor),
                  color: Colors.grey[200],
                  disabledColor: Colors.grey[200],
                  onPressed: () {
                    context
                        .bloc<MeetingsHomeBloc>()
                        .add(MeetingStatusToggled(_meeting.id));
                  },
                ),
              ),
              title: Text(
                _meeting.title,
                style: TextStyle(
                  color: PrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                _meeting.users.first.userName != null
                    ? _meeting.users.first.userName
                    : '-',
                style: TextStyle(
                  color: AccentColor,
                ),
              ),
            ),
            ListTile(
              trailing: IconButton(
                icon: Icon(
                  Icons.videocam_outlined,
                  color: AccentColor,
                ),
                onPressed: () {
                  context
                      .bloc<MeetingsHomeBloc>()
                      .add(MeetingEntered(_meeting.id));
                  _joinMeeting(_meeting.meetingRoom, _meeting.title,
                      _currentUser.username, _currentUser.email);
                },
              ),
              title: Text(
                _meeting.meetingStartsOn,
                style: TextStyle(
                  color: PrimaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
