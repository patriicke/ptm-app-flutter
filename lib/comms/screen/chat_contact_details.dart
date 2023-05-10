import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/blocs/login_type/login_type_bloc.dart';
import 'package:meetings/comms/bloc/contact_details/contact_details_bloc.dart';
import 'package:meetings/home/screen/create_meeting_screen.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

import '../../consts.dart';

class ChatContactDetails extends StatelessWidget {
  final String contactUserId;
  final String contactUserDescription;
  final int contactUserType;

  const ChatContactDetails(
      this.contactUserId, this.contactUserType, this.contactUserDescription);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactDetailsBloc, ContactDetailsState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        if (state is ContactDetailsLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ContactDetailsLoadSuccess) {
          var toReturnColumn = Column(children: [])
            ..children.add(_PersonalInfo())
            ..children.add(_AppSummary())
            ..children.add(const Padding(padding: EdgeInsets.only(top: 23)))
            ..children.add(_InvitationControls())
            ..children.add(const Padding(padding: EdgeInsets.only(top: 25)));
          if (state.isTeacher) {
            toReturnColumn.children.add(
              _TeacherAvailabilityList(state.teacherAvailability),
            );
          }
          return SingleChildScrollView(
            child: toReturnColumn,
          );
        } else if (state is ContactDetailsLoadFailure) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(state.error),
              TextButton(
                onPressed: () {
                  context.bloc<ContactDetailsBloc>().add(ContactDetailsLoaded(
                      contactUserId, contactUserType, contactUserDescription));
                },
                child: Text('Reload'),
              ),
            ],
          );
        } else {
          return Center(
            child: Text('Invalid data type'),
          );
        }
      },
    );
  }
}

class _PersonalInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactDetailsBloc, ContactDetailsState>(
      builder: (context, state) {
        if (state is ContactDetailsLoadSuccess) {
          var mainColumn = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.only(top: 30)),
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: Icon(
                  Icons.person,
                  color: PrimaryColor,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 7)),
              Text(state.contactUser.username),
              const Padding(padding: EdgeInsets.only(top: 7)),
            ],
          );
          var returnWidget = Container(
            width: double.infinity,
            color: AccentLightColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: mainColumn,
            ),
          );
          mainColumn.children.add(Text(state.contactUserDescription));
          mainColumn.children
              .add(const Padding(padding: EdgeInsets.only(top: 25)));
          return returnWidget;
        } else {
          return Text('Invalid state type');
        }
      },
    );
  }
}

class _AppSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactDetailsBloc, ContactDetailsState>(
      builder: (context, state) {
        if (state is ContactDetailsLoadSuccess) {
          return Container(
            color: Colors.grey[300],
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 11.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Meetings',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            state.contactUser.meetingsCount.toString(),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Reports',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            state.contactUser.reportsCount.toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 13.0)),
                ],
              ),
            ),
          );
        } else {
          return Text('Invalid state type!');
        }
      },
    );
  }
}

class _InvitationControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginTypeBloc, LoginType>(
      builder: (context, loginType) {
        return BlocBuilder<ContactDetailsBloc, ContactDetailsState>(
          builder: (context, contactDetailsState) {
            if (contactDetailsState is ContactDetailsLoadSuccess) {
              final _inviteContactButton = Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    width: 1.0,
                    color: PrimaryColor,
                  ),
                ),
                width: 200.0,
                height: 36.0,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      CreateMeetingScreen.route(
                        preselectedUserId: contactDetailsState.contactUser.id,
                        preselectedUserName:
                            contactDetailsState.contactUser.username,
                        preselectedUserType:
                            contactDetailsState.contactUser.userType,
                      ),
                    );
                  },
                  child: Text(
                    loginType == LoginType.teacher
                        ? 'Invite Parents'
                        : 'Create meeting request',
                    style: TextStyle(color: PrimaryColor),
                  ),
                ),
              );

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _inviteContactButton,
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Text('Invalid state type!');
            }
          },
        );
      },
    );
  }
}

class _TeacherAvailabilityList extends StatelessWidget {
  final List<TeacherAvailability> teacherAvailabilityList;
  const _TeacherAvailabilityList(this.teacherAvailabilityList);

  @override
  Widget build(BuildContext context) {
    var mainColumn = Column(children: []);
    mainColumn.children.add(
      Container(
        width: double.infinity,
        color: AccentLightColor,
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
        child: Text(
          'Weekly Schedule',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );

    for (var availability in teacherAvailabilityList) {
      mainColumn.children.add(
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
          title: Row(
            children: [
              Container(
                width: 80.0,
                child: Text(
                  availability.availabilityDate.toString(),
                  style: TextStyle(color: PrimaryColor),
                ),
              ),
              Text(
                '${availability.availabilityStartTime} - ${availability.availabilityEndTime}',
                style: TextStyle(
                  color: PrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return mainColumn;
  }
}
