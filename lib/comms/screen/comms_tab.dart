import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:meetings/blocs/authentication/authentication_bloc.dart';
import 'package:meetings/comms/bloc/comms_tab/commstab_bloc.dart';
import 'package:meetings/comms/screen/chat_screen.dart';
import 'package:meetings/comms/screen/contact_selection_screen.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

import '../../bannerads.dart';
import '../../consts.dart';

class CommsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return CommstabBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
          chatRepository: RepositoryProvider.of<ChatRepository>(context),
          meetingsRepository:
              RepositoryProvider.of<MeetingsRepository>(context),
        )..add(CommstabLoaded());
      },
      child: BlocBuilder<CommstabBloc, CommstabState>(
        buildWhen: (previous, current) =>
            previous.toString() != current.toString(),
        builder: (context, state) {
          if (state is CommstabLoadingInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CommstabLoadSuccess) {
            return _CommsNavPanel();
          } else if (state is CommstabLoadingFailed) {
            return _CommsPanelError(state.error);
          } else {
            return Center(
              child: Text('Invalid state type'),
            );
          }
        },
      ),
    );
  }
}

class _CommsNavPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CommsNavPanelState();
}

class _CommsNavPanelState extends State<_CommsNavPanel>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> tabs = <Tab>[
    Tab(child: Text('Chat')),
    Tab(child: Text('Meetings')),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              TabBar(
                tabs: tabs,
                controller: this._tabController,
              ),
              Expanded(
                child: Stack(
                  children: [
                    TabBarView(
                      controller: _tabController,
                      children: [
                        _MessagesTab(),
                        _MeetingsTab(),
                      ],
                    ),
                    Positioned(
                      child: FloatingActionButton(
                        backgroundColor: PrimaryColor,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(ContactSelectionScreen.route());
                        },
                      ),
                      bottom: 16,
                      right: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // BannerAdmob(),
        SizedBox(height: 5),
      ],
    );
  }
}

class _CommsPanelError extends StatelessWidget {
  final String error;

  _CommsPanelError(this.error);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(error),
        TextButton(
          onPressed: () {
            context.bloc<CommstabBloc>().add(CommstabLoaded());
          },
          child: Text('Reload'),
        ),
      ],
    );
  }
}

class _MessagesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommstabBloc, CommstabState>(
      builder: (context, state) {
        var mainColumn = Column(
          children: [],
        );
        for (var contact in (state as CommstabLoadSuccess).contactChats) {
          mainColumn.children.add(_ChatListItem(contact));
        }
        return SingleChildScrollView(
          child: mainColumn,
        );
      },
    );
  }
}

class _ChatListItem extends StatelessWidget {
  final ChatContactDto contact;

  const _ChatListItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(ChatScreen.route(contact.contactUserId));
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 30),
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: IconButton(
          icon: Icon(Icons.person, color: AccentColor),
          color: Colors.grey[200],
          disabledColor: Colors.grey[200],
          onPressed: () {},
        ),
      ),
      title: Text(
        contact.contactUserName,
        style: TextStyle(
          color: PrimaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        contact.lastMessageBody,
        style: TextStyle(
          color: PrimaryColor,
          fontSize: 14,
        ),
      ),
      /*trailing: Badge(
        shape: BadgeShape.circle,
        badgeColor: PrimaryColor,
        badgeContent: Text(
          contact.unreadMessagesCount.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),*/
    );
  }
}

class _MeetingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommstabBloc, CommstabState>(
      builder: (context, commstabState) {
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authState) {
            var mainColumn = Column(children: []);
            for (var meeting
                in (commstabState as CommstabLoadSuccess).attendedMeetings) {
              mainColumn.children
                  .add(_MeetingListItem(meeting, authState.user));
            }
            return SingleChildScrollView(
              child: mainColumn,
            );
          },
        );
      },
    );
  }
}

class _MeetingListItem extends StatelessWidget {
  final Meeting meeting;
  final UserEntity currentUser;

  const _MeetingListItem(this.meeting, this.currentUser);

  _joinMeeting(String room, String subject, String userDisplayName,
      String userEmail) async {
    try {
      /*FeatureFlag featureFlag = FeatureFlag();
      featureFlag.addPeopleEnabled = false;
      featureFlag.inviteEnabled = false;*/

      //   Map<FeatureFlagEnum, bool> featureFlags = {
      //     FeatureFlagEnum.ADD_PEOPLE_ENABLED: false,
      //     FeatureFlagEnum.INVITE_ENABLED: false,
      //   };

      //   var options =
      //       JitsiMeetingOptions(room: room) // Required, spaces will be trimmed
      //         ..serverURL = "https://meet.parentteachermobile.com/"
      //         ..subject = subject
      //         ..userDisplayName = userDisplayName
      //         ..userEmail = userEmail
      //         ..audioOnly = true
      //         ..audioMuted = true
      //         ..videoMuted = true
      //         ..featureFlags.addAll(featureFlags);

      //   debugPrint("JitsiMeetingOptions: $options");
      //   //await JitsiMeet.joinMeeting(options, roomNameConstraints: Map());
      //   await JitsiMeet.joinMeeting(
      //     options,
      //     roomNameConstraints: Map(),
      //     listener: JitsiMeetingListener(
      //         onConferenceWillJoin: (message) {
      //           debugPrint("${options.room} will join with message: $message");
      //         },
      //         onConferenceJoined: (message) {
      //           debugPrint("${options.room} joined with message: $message");
      //         },
      //         onConferenceTerminated: (message) {
      //           debugPrint("${options.room} terminated with message: $message");
      //         },
      //         genericListeners: [
      //           JitsiGenericListener(
      //               eventName: 'readyToClose',
      //               callback: (dynamic message) {
      //                 debugPrint("readyToClose callback");
      //               }),
      //         ]),
      //   );
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    log(currentUser.toString());
    log(meeting.toString());
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 30),
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: IconButton(
          icon: Icon(Icons.person, color: AccentColor),
          color: Colors.grey[200],
          disabledColor: Colors.grey[200],
          onPressed: () {},
        ),
      ),
      title: Text(
        meeting.title == null ? '' : meeting.title,
        style: TextStyle(
          color: PrimaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      subtitle: Row(
        children: [
          Icon(
            Icons.call_made,
            color: PrimaryColor,
            size: 18,
          ),
          const Padding(padding: EdgeInsets.only(left: 8)),
          Text(
            meeting.lastEnteredOn == null ? '' : meeting.lastEnteredOn,
            style: TextStyle(
              color: PrimaryColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: () => _joinMeeting(meeting.meetingRoom,
            meeting.meetingSubject, currentUser.username, currentUser.email),
        icon: Icon(Icons.videocam_outlined),
        color: PrimaryColor,
      ),
    );
  }
}
