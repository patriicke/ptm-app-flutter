import 'dart:developer';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/blocs/login_type/login_type_bloc.dart';
import 'package:intl/intl.dart';
import 'package:formz/formz.dart';
import 'package:meetings/home/bloc/meeting_request/meeting_request_bloc.dart';
import 'package:meetings/landing/screen/landing_screen.dart';
import 'package:repository_core/repository_core.dart';

import '../../consts.dart';

class CreateMeetingForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MeetingRequestBloc, MeetingRequestState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Meeting Creation Failed: ${state.error}'),
              ),
            );
        } else if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pushReplacement(LandingScreenNew.route());
        }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 24)),
            Text(
              'Create meeting',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: PrimaryColor,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            _TitleInput(),
            const Padding(padding: EdgeInsets.only(top: 30)),
            _RecipientInput(),
            const Padding(padding: EdgeInsets.only(top: 30)),
            _MeetingDateInput(),
            const Padding(padding: EdgeInsets.only(top: 30)),
            _MeetingTimeInput(),
            const Padding(padding: EdgeInsets.only(top: 30)),
            _CreateRequestButton()
          ],
        ),
      ),
    );
  }
}

class _TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingRequestBloc, MeetingRequestState>(
      buildWhen: (previous, current) =>
          previous.meetingTitle != current.meetingTitle ||
          previous.status != current.status,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: TextStyle(fontSize: 16, color: PrimaryColor),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            TextField(
              key: const Key('createMeetingForm_meetingTitleInput_textField'),
              enabled: !state.status.isSubmissionInProgress,
              onChanged: (title) => context
                  .bloc<MeetingRequestBloc>()
                  .add(MeetingTitleUpdated(title)),
              decoration: InputDecoration(
                // errorText: state.meetingTitle.errorText(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusColor: PrimaryColor,
                hoverColor: PrimaryColor,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RecipientInput extends StatelessWidget {
  final _controller = TextEditingController();
  Widget _searchResultList(BuildContext context) {
    return BlocBuilder<MeetingRequestBloc, MeetingRequestState>(
      buildWhen: (previous, current) =>
          previous.searchedUsers != current.searchedUsers ||
          previous.status != current.status ||
          previous.searchStatus != current.searchStatus,
      builder: (context, state) {
        return state.searchStatus.isSubmissionInProgress
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: state.searchedUsers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    key: Key(
                        '__searched_teacher_${state.searchedUsers[index].id}__'),
                    title: Text('${state.searchedUsers[index].name}'),
                    trailing: !state.selectedRecipientUsers.any((recipient) =>
                            recipient.userId == state.searchedUsers[index].id)
                        ? null
                        : Icon(
                            Icons.check,
                            color: PrimaryColor,
                          ),
                    onTap: () {
                      context.bloc<MeetingRequestBloc>().add(
                          RecipientSelected(state.searchedUsers[index].id));
                      Navigator.pop(context);
                    },
                  );
                },
              );
      },
    );
  }

  void _searchResultsBottomSheet(BuildContext context) {
    final provider = BlocProvider.of<MeetingRequestBloc>(context);
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            height: 300,
            child: BlocProvider.value(
              child: _searchResultList(context),
              value: provider,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MeetingRequestBloc, MeetingRequestState>(
      listenWhen: (previous, current) =>
          previous.searchStatus != current.searchStatus ||
          previous.selectedRecipientUsers != current.selectedRecipientUsers,
      listener: (context, listenerState) {
        switch (listenerState.searchStatus) {
          case FormzStatus.submissionSuccess:
            _searchResultsBottomSheet(context);
            break;
          default:
        }
      },
      child: BlocBuilder<MeetingRequestBloc, MeetingRequestState>(
        buildWhen: (previous, current) =>
            previous.meetingRecipient != current.meetingRecipient ||
            previous.searchStatus != current.searchStatus ||
            previous.status != current.status ||
            previous.selectedRecipientUsers != current.selectedRecipientUsers,
        builder: (context, builderState) {
          var mainColumn = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.bloc<LoginTypeBloc>().state == LoginType.parent
                    ? 'Parents'
                    : 'Teachers',
                style: TextStyle(fontSize: 16, color: PrimaryColor),
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              Text('Press the search button to find users'),
              const Padding(padding: EdgeInsets.only(top: 5)),
              TextField(
                key: const Key(
                    'createMeetingForm_meetingRecipientInput_textField'),
                controller: _controller,
                enabled: !builderState.status.isSubmissionInProgress,
                onChanged: (recipient) => context
                    .bloc<MeetingRequestBloc>()
                    .add(MeetingRecipientUpdated(recipient)),
                decoration: InputDecoration(
                  suffixIcon: builderState.searchStatus.isSubmissionInProgress
                      ? Container(
                          padding: EdgeInsets.all(10.0),
                          child: CircularProgressIndicator(),
                        )
                      : IconButton(
                          icon: Icon(Icons.search),
                          onPressed: builderState.meetingRecipient.pure == true
                              ? null
                              : () {
                                  context
                                      .bloc<MeetingRequestBloc>()
                                      .add(RecipientSearchRequested());
                                },
                        ),
                  // errorText: state.meetingTitle.errorText(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusColor: PrimaryColor,
                  hoverColor: PrimaryColor,
                ),
              ),
            ],
          );
          if (builderState.selectedRecipientUsers != null) {
            if (builderState.selectedRecipientUsers.length > 0) {
              mainColumn.children
                  .add(const Padding(padding: EdgeInsets.only(top: 5)));
              mainColumn.children.add(Text(
                  '${builderState.selectedRecipientUsers.length.toString()} users selected'));
            }
          }
          return mainColumn;
        },
      ),
    );
  }
}

class _MeetingDateInput extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingRequestBloc, MeetingRequestState>(
      buildWhen: (previous, current) =>
          previous.meetingDate != current.meetingDate ||
          previous.status != current.status,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pick Date',
              style: TextStyle(fontSize: 16, color: PrimaryColor),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            DateTimeField(
              key: const Key('createMeetingForm_meetingDateInput_textField'),
              enabled: !state.status.isSubmissionInProgress,
              onChanged: (meetingDate) => context
                  .bloc<MeetingRequestBloc>()
                  .add(MeetingDateUpdated(meetingDate.toIso8601String())),
              decoration: InputDecoration(
                // errorText: state.meetingTitle.errorText(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusColor: PrimaryColor,
                hoverColor: PrimaryColor,
              ),
              format: format,
              onShowPicker: (BuildContext context, DateTime currentValue) {
                return showDatePicker(
                  context: context,
                  initialDate: currentValue ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _MeetingTimeInput extends StatelessWidget {
  final format = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingRequestBloc, MeetingRequestState>(
      buildWhen: (previous, current) =>
          previous.meetingTime != current.meetingTime ||
          previous.status != current.status,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pick Time',
              style: TextStyle(fontSize: 16, color: PrimaryColor),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            DateTimeField(
              key: const Key('createMeetingForm_meetingTimeInput_textField'),
              enabled: !state.status.isSubmissionInProgress,
              onChanged: (meetingTime) => context
                  .bloc<MeetingRequestBloc>()
                  .add(MeetingTimeUpdated(meetingTime.toIso8601String())),
              decoration: InputDecoration(
                // errorText: state.meetingTitle.errorText(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusColor: PrimaryColor,
                hoverColor: PrimaryColor,
              ),
              format: format,
              onShowPicker:
                  (BuildContext context, DateTime currentValue) async {
                final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(
                      currentValue ?? DateTime.now(),
                    ));
                return DateTimeField.convert(time);
              },
            ),
          ],
        );
      },
    );
  }
}

class _CreateRequestButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingRequestBloc, MeetingRequestState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.searchStatus != current.searchStatus ||
          previous.selectedRecipientUsers != current.selectedRecipientUsers,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Container(
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
                      'Send Invite',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  key:
                      const Key('createMeetingForm_createMeeting_raisedButton'),
                  onPressed: state.status.isValidated &&
                          !state.searchStatus.isSubmissionInProgress &&
                          state.selectedRecipientUsers != null
                      ? () {
                          context
                              .bloc<MeetingRequestBloc>()
                              .add(MeetingRequestSubmitted());
                        }
                      : null,
                ),
              );
      },
    );
  }
}
