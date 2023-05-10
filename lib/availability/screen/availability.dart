import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:meetings/availability/bloc/availability_details/availability_details_bloc.dart';
import 'package:meetings/availability/screen/set_availability_screen.dart';
import 'package:meetings/profile/bloc/user_profile/user_profile_bloc.dart';
import 'package:swagger_api/swagger_api.dart';

import '../../consts.dart';

class Availability extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailabilityDetailsBloc, AvailabilityDetailsState>(
      builder: (context, state) {
        if (state is AvailabilityDetailsLoadingInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AvailabilityDetailsLoadSuccess) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: _AvailabilityCalendar(),
                ),
                _WhoCanSeeMenu(),
                Divider(
                  thickness: 2.0,
                  height: 0.0,
                ),
                _AvailabilityList(),
                _SetAvailabilityNavigator(),
              ],
            ),
          );
        } else if (state is AvailabilityDetailsLoadFailure) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(state.error),
              TextButton(
                onPressed: () {
                  context
                      .bloc<AvailabilityDetailsBloc>()
                      .add(AvailabilityDetailsLoaded());
                },
                child: Text('Reload'),
              ),
            ],
          );
        } else {
          return Center(
            child: Text('Invalid state type'),
          );
        }
      },
    );
  }
}

class _AvailabilityCalendar extends StatefulWidget {
  _AvailabilityCalendar({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AvailabilityCalendarState createState() => _AvailabilityCalendarState();
}

class _AvailabilityCalendarState extends State<_AvailabilityCalendar> {
  DateTime _currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String _currentMonth = DateFormat.yMMM().format(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
  DateTime _targetDateTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailabilityDetailsBloc, AvailabilityDetailsState>(
      builder: (context, state) {
        if (state is AvailabilityDetailsLoadSuccess) {
          return Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 31)),
              CalendarCarousel<Event>(
                onDayPressed: (DateTime date, List<Event> events) {
                  log(date.toString());
                  this.setState(() => _currentDate = date);
                },
                onRightArrowPressed: () {
                  setState(() {
                    _targetDateTime = DateTime(
                        _targetDateTime.year, _targetDateTime.month + 1);
                    _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                  });
                },
                onLeftArrowPressed: () {
                  setState(() {
                    _targetDateTime = DateTime(
                        _targetDateTime.year, _targetDateTime.month - 1);
                    _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                  });
                },
                headerTextStyle: TextStyle(
                  color: PrimaryColor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
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
                markedDatesMap: state.availabilityEvents,
                thisMonthDayBorderColor: Colors.grey,
                weekFormat: false,
                height: 360,
                selectedDateTime: _currentDate,
                targetDateTime: _targetDateTime,
                showHeader: true,
                onCalendarChanged: (date) {
                  this.setState(() {
                    log(date.toString());
                    _targetDateTime = date;
                    _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                  });
                },
              ),
            ],
          );
        } else {
          return Text('Invalid state type');
        }
      },
    );
  }
}

class _WhoCanSeeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailabilityDetailsBloc, AvailabilityDetailsState>(
      builder: (context, state) {
        if (state is AvailabilityDetailsLoadSuccess) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
            title: Text(
              'Who can see schedule?',
              style: TextStyle(color: Colors.grey),
            ),
            trailing: DropdownButton(
              iconEnabledColor: PrimaryColor,
              items: [
                DropdownMenuItem(
                  child: Text(
                    'Everyone',
                    style: TextStyle(
                        color: PrimaryColor, fontWeight: FontWeight.w400),
                  ),
                  value: WhoCanSeeAvailability.everyone,
                ),
                DropdownMenuItem(
                  child: Text(
                    'Just Me',
                    style: TextStyle(
                        color: PrimaryColor, fontWeight: FontWeight.w400),
                  ),
                  value: WhoCanSeeAvailability.justMe,
                ),
              ],
              onChanged: (WhoCanSeeAvailability value) {
                context
                    .bloc<AvailabilityDetailsBloc>()
                    .add(AvailabilityDetailsLoaded(whoCanSeeFilter: value));
              },
              value: state.availabilityFilter,
            ),
          );
        } else {
          return Text('Invalid state type');
        }
      },
    );
  }
}

class _AvailabilityList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailabilityDetailsBloc, AvailabilityDetailsState>(
      builder: (context, state) {
        if (state is AvailabilityDetailsLoadSuccess) {
          if (state.teacherAvailability.length <= 0) {
            return Center(
              child: Text('No availability found'),
            );
          }
          var listItems = <Widget>[];
          state.teacherAvailability.forEach((day) {
            return listItems.add(new _AvailabilityListItem(day));
          });
          return Column(
            children: listItems,
          );
        } else {
          return Text('Invalid state type');
        }
      },
    );
  }
}

class _AvailabilityListItem extends StatelessWidget {
  _AvailabilityListItem(this.availabilityDay);
  final TeacherAvailability availabilityDay;
  final DateFormat dateFormatter = DateFormat('yMMMEd');
  final DateFormat timeFormatter = DateFormat('jm');

  @override
  Widget build(BuildContext context) {
    try {
      DateTime.parse(availabilityDay.availabilityDate);
    } catch (e) {
      return Text(
          'Error: Could not parse date ${availabilityDay.availabilityDate}');
    }
    return Column(
      children: [
        ListTile(
          tileColor: AccentLightColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
          title: Text(
            dateFormatter
                .format(DateTime.parse(availabilityDay.availabilityDate))
                .toString(),
            style: TextStyle(color: PrimaryColor),
          ),
          trailing: Icon(
            Icons.add_circle_outline,
            color: PrimaryColor,
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
          title: Row(
            children: [
              CircleAvatar(
                radius: 4.0,
                backgroundColor:
                    availabilityDay.availabilityType == 'availableForMeetings'
                        ? PrimaryColor
                        : AccentColor,
              ),
              const Padding(padding: EdgeInsets.only(right: 8)),
              availabilityDay.availabilityType == 'availableForMeetings'
                  ? Text(
                      '${availabilityDay.availabilityStartTime} - ${availabilityDay.availabilityEndTime}',
                      style: TextStyle(color: PrimaryColor),
                    )
                  : Text(
                      'Unavailable all day',
                      style: TextStyle(color: AccentColor),
                    ),
            ],
          ),
        )
      ],
    );
  }
}

class _SetAvailabilityNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        'Set availability',
        style: TextStyle(
          color: PrimaryColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(SetAvailabilityScreen.route());
      },
    );
  }
}
