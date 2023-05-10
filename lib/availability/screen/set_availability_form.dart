import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/availability/bloc/availability_form/availability_form_bloc.dart';
import 'package:meetings/consts.dart';
import 'package:intl/intl.dart';
import 'package:meetings/profile/bloc/user_profile/user_profile_bloc.dart';
import 'package:formz/formz.dart';

class SetAvailabilityForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AvailabilityFormBloc, AvailabilityFormState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
        } else if (state.status.isSubmissionSuccess) {
          Navigator.pop(context);
        }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 24)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Set availability',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: PrimaryColor),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            _DateControl(),
            const Padding(padding: EdgeInsets.only(top: 31)),
            _AvailabilityControl(),
            const Padding(padding: EdgeInsets.only(top: 35)),
            _StartTimeInput(),
            const Padding(padding: EdgeInsets.only(top: 35)),
            _EndTimeInput(),
            const Padding(padding: EdgeInsets.only(top: 51)),
            _RepeatControl(),
            const Padding(padding: EdgeInsets.only(top: 20)),
            _WhoCanSeeMenu(),
            const Padding(padding: EdgeInsets.only(top: 20)),
            _SaveButton(),
            const Padding(padding: EdgeInsets.only(top: 35)),
          ],
        ),
      ),
    );
  }
}

// class _DateControl extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 30),
//       child: Row(
//         children: [
//           Text(
//             'Thu, 6 Apr 2020',
//             style: TextStyle(color: PrimaryColor),
//           ),
//           const Padding(padding: EdgeInsets.only(left: 9)),
//           Icon(
//             Icons.calendar_today,
//             size: 15.0,
//             color: PrimaryColor,
//           ),
//         ],
//       ),
//     );
//   }
// }

class _DateControl extends StatelessWidget {
  final format = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailabilityFormBloc, AvailabilityFormState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: DateTimeField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusColor: PrimaryColor,
              hoverColor: PrimaryColor,
              suffixIcon: Icon(
                Icons.calendar_today,
                color: AccentColor,
              ),
              fillColor: Colors.white,
              filled: true,
            ),
            cursorColor: PrimaryColor,
            format: format,
            onChanged: (meetingDate) => context
                .bloc<AvailabilityFormBloc>()
                .add(DateUpdated(meetingDate.toIso8601String())),
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                context: context,
                initialDate: currentValue ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
            },
          ),
        );
      },
    );
  }
}

class _AvailabilityControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailabilityFormBloc, AvailabilityFormState>(
      builder: (context, state) {
        return Column(
          children: [
            RadioListTile(
              title: Text(
                'Unavailable',
                style: TextStyle(color: PrimaryColor),
              ),
              activeColor: PrimaryColor,
              value: AvailabilityType.unavailable,
              groupValue: state.availabilityType,
              onChanged: (AvailabilityType value) {
                context
                    .bloc<AvailabilityFormBloc>()
                    .add(AvailabilityTypeUpdated(value));
              },
            ),
            RadioListTile(
              activeColor: PrimaryColor,
              title: Text(
                'Available for meetings',
                style: TextStyle(color: PrimaryColor),
              ),
              value: AvailabilityType.availableForMeetings,
              groupValue: state.availabilityType,
              onChanged: (AvailabilityType value) {
                context
                    .bloc<AvailabilityFormBloc>()
                    .add(AvailabilityTypeUpdated(value));
              },
            ),
          ],
        );
      },
    );
  }
}

class _StartTimeInput extends StatelessWidget {
  final format = DateFormat("jm");
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailabilityFormBloc, AvailabilityFormState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select start time',
                style: TextStyle(fontSize: 16, color: PrimaryColor),
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              DateTimeField(
                key: const Key(
                    'setAvailabilityForm_availabilityStartTimeInput_textField'),
                onChanged: (startTime) {
                  context
                      .bloc<AvailabilityFormBloc>()
                      .add(StartTimeUpdated(startTime.toIso8601String()));
                },
                decoration: InputDecoration(
                    // errorText: state.meetingTitle.errorText(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusColor: PrimaryColor,
                    hoverColor: PrimaryColor,
                    suffixIcon: Icon(
                      Icons.access_time,
                      color: AccentColor,
                    )),
                format: format,
                onShowPicker:
                    (BuildContext context, DateTime currentValue) async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(
                      currentValue ?? DateTime.now(),
                    ),
                  );
                  return DateTimeField.convert(time);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EndTimeInput extends StatelessWidget {
  final format = DateFormat("jm");
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailabilityFormBloc, AvailabilityFormState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select end time',
                style: TextStyle(fontSize: 16, color: PrimaryColor),
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              DateTimeField(
                key: const Key(
                    'setAvailabilityForm_availabilityEndTimeInput_textField'),
                onChanged: (endTime) {
                  context
                      .bloc<AvailabilityFormBloc>()
                      .add(EndTimeUpdated(endTime.toIso8601String()));
                },
                decoration: InputDecoration(
                    // errorText: state.meetingTitle.errorText(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusColor: PrimaryColor,
                    hoverColor: PrimaryColor,
                    suffixIcon: Icon(
                      Icons.access_time,
                      color: AccentColor,
                    )),
                format: format,
                onShowPicker:
                    (BuildContext context, DateTime currentValue) async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(
                      currentValue ?? DateTime.now(),
                    ),
                  );
                  return DateTimeField.convert(time);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RepeatControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailabilityFormBloc, AvailabilityFormState>(
      buildWhen: (previous, current) => previous.repeats != current.repeats,
      builder: (context, state) {
        var mainColumn = Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Text(
                    'Repeat',
                    style: TextStyle(color: PrimaryColor, fontSize: 16),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 30)),
                  Switch(
                    value: state.repeats,
                    onChanged: (bool value) {
                      context.bloc<AvailabilityFormBloc>().add(RepeatToggled());
                    },
                    activeColor: PrimaryColor,
                  ),
                ],
              ),
            ),
          ],
        );
        if (state.repeats) {
          mainColumn.children.add(_RepeatDetailsControl());
        }
        return mainColumn;
      },
    );
  }
}

class _RepeatDetailsControl extends StatelessWidget {
  final format = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailabilityFormBloc, AvailabilityFormState>(
      buildWhen: (previous, current) =>
          previous.repeatsEvery != current.repeatsEvery ||
          previous.repeatEndDate != current.repeatEndDate,
      builder: (context, state) {
        return Container(
          color: AccentLightColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Every',
                  style: TextStyle(color: PrimaryColor, fontSize: 16),
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                DropdownButtonFormField(
                  iconEnabledColor: AccentColor,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  value: state.repeatsEvery,
                  items: [
                    DropdownMenuItem(
                      child: Text('Day'),
                      value: RepeatType.day,
                    ),
                    DropdownMenuItem(
                      child: Text('Week'),
                      value: RepeatType.week,
                    ),
                    DropdownMenuItem(
                      child: Text('Month'),
                      value: RepeatType.month,
                    ),
                    DropdownMenuItem(
                      child: Text('Year'),
                      value: RepeatType.year,
                    ),
                  ],
                  onChanged: (RepeatType value) {
                    context
                        .bloc<AvailabilityFormBloc>()
                        .add(RepeatsEveryUpdated(value));
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 35)),
                Text(
                  'Ends on',
                  style: TextStyle(color: PrimaryColor, fontSize: 16),
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                DateTimeField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusColor: PrimaryColor,
                    hoverColor: PrimaryColor,
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: AccentColor,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  cursorColor: PrimaryColor,
                  format: format,
                  onChanged: (meetingDate) => context
                      .bloc<AvailabilityFormBloc>()
                      .add(RepeatEndDateUpdated(meetingDate.toIso8601String())),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                      context: context,
                      initialDate: currentValue ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _WhoCanSeeMenu extends StatefulWidget {
  @override
  _WhoCanSeeMenuState createState() => _WhoCanSeeMenuState();
}

class _WhoCanSeeMenuState extends State<_WhoCanSeeMenu> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailabilityFormBloc, AvailabilityFormState>(
      builder: (context, state) {
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
              context.bloc<AvailabilityFormBloc>().add(WhoCanSeeUpdated(value));
            },
            value: state.whoCanSee,
          ),
        );
      },
    );
  }
}

class _SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailabilityFormBloc, AvailabilityFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: PrimaryColor,
                      textStyle: TextStyle(color: Colors.white, fontSize: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  key: const Key(
                      'setAvailabilityForm_saveAvailability_raisedButton'),
                  onPressed: state.status.isValidated
                      ? () {
                          context
                              .bloc<AvailabilityFormBloc>()
                              .add(AvailabilityFormSubmitted());
                        }
                      : null,
                ),
              );
      },
    );
  }
}
