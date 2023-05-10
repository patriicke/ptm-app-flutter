import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/blocs/login_type/login_type_bloc.dart';
import 'package:meetings/consts.dart';
import 'package:meetings/availability/screen/availability_details_screen.dart';
import 'package:meetings/home/screen/create_meeting_screen.dart';
import 'package:meetings/profile/bloc/user_profile/user_profile_bloc.dart';
import 'package:meetings/profile/screen/edit_details_screen.dart';
import 'package:meetings/profile/screen/email_invite_screen.dart';
import 'package:repository_core/repository_core.dart';
import 'package:formz/formz.dart';

import '../../bannerads.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        if (state is UserProfileLoadingInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UserProfileLoadSuccess) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _PersonalInfo(),
                      _AppSummary(),
                      const Padding(padding: EdgeInsets.only(top: 23)),
                      _InvitationControls(),
                      const Padding(padding: EdgeInsets.only(top: 25)),
                      _AccountSettings(),
                      _AppSettings(),
                      const Padding(padding: EdgeInsets.only(top: 23)),
                      _LogoutButton(),
                      const Padding(padding: EdgeInsets.only(bottom: 23)),
                    ],
                  ),
                ),
              ),
              // BannerAdmob(),
              SizedBox(height: 5)
            ],
          );
        } else if (state is UserProfileLoadFailure) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(state.error),
              TextButton(
                onPressed: () {
                  context.bloc<UserProfileBloc>().add(UserProfileLoaded());
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

class _LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.bloc<UserProfileBloc>().add(LogoutRequested()),
      child: Text(
        'Logout',
        style: TextStyle(
          color: PrimaryColor,
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class _PersonalInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginTypeBloc, LoginType>(
      builder: (context, loginType) {
        return BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoadSuccess) {
              var mainAvatar = CircleAvatar(
                backgroundColor: Colors.grey[300],
                backgroundImage: NetworkImage(
                    state.userDetails.photoImageLink == null
                        ? ''
                        : state.userDetails.photoImageLink),
                onBackgroundImageError: (exception, stacktrace) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                            'Unable to load image: { link: ${state.userDetails.photoImageLink} }'),
                      ),
                    );
                },
                // child: Icon(
                //   Icons.person,
                //   color: PrimaryColor,
                // ),
              );
              var mainColumn = Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  mainAvatar,
                  const Padding(padding: EdgeInsets.only(top: 7)),
                  Text(state.userDetails.username == null
                      ? ''
                      : state.userDetails.username),
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
              if (loginType == LoginType.parent) {
                mainColumn.children.add(Text(state.userDetails.about == null
                    ? ''
                    : state.userDetails.about));
                mainColumn.children
                    .add(const Padding(padding: EdgeInsets.only(top: 25)));
              } else if (loginType == LoginType.teacher) {
                mainColumn.children.add(GestureDetector(
                  child: Text(
                    'Set availability',
                    style: TextStyle(
                      color: PrimaryColor,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(AvailabilityDetailsScreen.route());
                  },
                ));
                mainColumn.children
                    .add(const Padding(padding: EdgeInsets.only(top: 25)));
              }
              return returnWidget;
            } else {
              return Text('Invalid state type');
            }
          },
        );
      },
    );
  }
}

class _AppSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginTypeBloc, LoginType>(
      builder: (context, loginType) {
        return BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoadSuccess) {
              return Container(
                color: Colors.grey[300],
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 11.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Total Meetings',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                state.userDetails.meetingsCount.toString(),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                context.bloc<LoginTypeBloc>().state ==
                                        LoginType.parent
                                    ? 'Teachers'
                                    : 'Parents',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                context.bloc<LoginTypeBloc>().state ==
                                        LoginType.parent
                                    ? state.userDetails.teachersCount.toString()
                                    : state.userDetails.parentsCount.toString(),
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
                                state.userDetails.reportsCount.toString(),
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
              return Text('Invalid state type');
            }
          },
        );
      },
    );
  }
}

class _InvitationControls extends StatelessWidget {
  void _showPicker(context) {
    final provider = BlocProvider.of<UserProfileBloc>(context);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: provider,
          child: SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                    title: new Text(
                      'Invite Parents',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    trailing: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                  new Divider(
                    thickness: 2.0,
                    height: 0,
                  ),
                  new Container(
                    padding: EdgeInsets.symmetric(horizontal: 85, vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                              ..pop()
                              ..push(EmailInviteScreen.route());
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.mail_outline,
                                color: PrimaryColor,
                              ),
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              Text(
                                'Mail',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        BlocBuilder<UserProfileBloc, UserProfileState>(
                          builder: (context, state) {
                            return TextButton(
                              onPressed: () {
                                context
                                    .bloc<UserProfileBloc>()
                                    .add(InviteLinkRequested());
                                Navigator.of(context).pop();
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.file_copy_outlined,
                                    color: PrimaryColor,
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 10)),
                                  Text(
                                    'Copy Link',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _inviteParentButton = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          width: 1.0,
          color: PrimaryColor,
        ),
      ),
      width: 142.0,
      height: 36.0,
      child: TextButton(
        onPressed: () {
          _showPicker(context);
        },
        child: Text(
          'Invite Parents',
          style: TextStyle(color: PrimaryColor),
        ),
      ),
    );

    final _inviteTeacherButton = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          width: 1.0,
          color: PrimaryColor,
        ),
      ),
      width: 142.0,
      height: 36.0,
      child: TextButton(
        onPressed: () {
          Navigator.push(context, CreateMeetingScreen.route());
        },
        child: Text(
          'Invite Teachers',
          style: TextStyle(color: PrimaryColor),
        ),
      ),
    );

    return BlocListener<UserProfileBloc, UserProfileState>(
      listener: (context, state) {
        if (state is UserProfileLoadSuccess) {
          if (state.inviteLinkStatus.isSubmissionSuccess) {
            Clipboard.setData(ClipboardData(text: state.inviteLink));

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Invite link copied to clipboard'),
                ),
              );
          }
          if (state.inviteLinkStatus.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.inviteLinkError}'),
                ),
              );
          }
        }
      },
      child: BlocBuilder<LoginTypeBloc, LoginType>(
        builder: (context, loginType) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                loginType == LoginType.parent
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _inviteParentButton,
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [_inviteParentButton, _inviteTeacherButton],
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AccountSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: AccentLightColor,
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
          child: Text(
            'Account',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        // ListTile(
        //   contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
        //   onTap: () => Navigator.push(context, EditDetailsScreen.route()),
        //   title: Text(
        //     'Email',
        //     style: TextStyle(color: Colors.grey),
        //   ),
        //   trailing: Icon(
        //     Icons.chevron_right,
        //     color: Colors.black,
        //   ),
        // ),
        // ListTile(
        //   contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
        //   onTap: () => Navigator.push(context, EditDetailsScreen.route()),
        //   title: Text(
        //     'Phone No.',
        //     style: TextStyle(color: Colors.grey),
        //   ),
        //   trailing: Icon(
        //     Icons.chevron_right,
        //     color: Colors.black,
        //   ),
        // ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
          onTap: () => Navigator.push(context, EditDetailsScreen.route()),
          title: Text(
            'Change Password',
            style: TextStyle(color: Colors.grey),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class _AppSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginTypeBloc, LoginType>(
      builder: (context, loginType) {
        return BlocBuilder<UserProfileBloc, UserProfileState>(
          buildWhen: (previous, current) =>
              (previous as UserProfileLoadSuccess).whoCanSee !=
                  (current as UserProfileLoadSuccess).whoCanSee ||
              (previous as UserProfileLoadSuccess).notificationEnabled !=
                  (current as UserProfileLoadSuccess).notificationEnabled,
          builder: (context, state) {
            if (state is UserProfileLoadSuccess) {
              var returnColum = Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: AccentLightColor,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    child: Text(
                      'App',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                    title: Text(
                      'Notifications',
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: Switch(
                      activeColor: PrimaryColor,
                      value: state.notificationEnabled,
                      onChanged: (bool value) {
                        context
                            .bloc<UserProfileBloc>()
                            .add(NotificationSettingToggled());
                      },
                    ),
                  ),
                ],
              );
              if (context.bloc<LoginTypeBloc>().state == LoginType.teacher) {
                returnColum.children.add(
                  ListTile(
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
                                color: PrimaryColor,
                                fontWeight: FontWeight.w400),
                          ),
                          value: WhoCanSeeAvailability.everyone,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Just Me',
                            style: TextStyle(
                                color: PrimaryColor,
                                fontWeight: FontWeight.w400),
                          ),
                          value: WhoCanSeeAvailability.justMe,
                        ),
                      ],
                      onChanged: (WhoCanSeeAvailability value) {
                        context
                            .bloc<UserProfileBloc>()
                            .add(WhoCanSeeScheduleUpdated(value));
                      },
                      value: state.whoCanSee,
                    ),
                  ),
                );
              }
              return returnColum;
            } else {
              return Text('Invalid state type');
            }
          },
        );
      },
    );
  }
}
