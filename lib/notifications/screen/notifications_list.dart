import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/blocs/login_type/login_type_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meetings/notifications/bloc/notifications_list/notifications_list_bloc.dart';
import 'package:meetings/notifications/screen/connection_approval_screen.dart';
import 'package:meetings/notifications/screen/meeting_approval_screen.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

import '../../bannerads.dart';
import '../../consts.dart';

class NotificationsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsListBloc, NotificationsListState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        if (state is NotificationsListLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NotificationsListLoadSuccess) {
          return _NotificationsTabPanel();
        } else if (state is NotificationsListLoadFailure) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(state.error),
              TextButton(
                onPressed: () {
                  context
                      .bloc<NotificationsListBloc>()
                      .add(NotificationsListLoaded());
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

class _NotificationsTabPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationsTabPanelState();
}

class _NotificationsTabPanelState extends State<_NotificationsTabPanel>
    with TickerProviderStateMixin {
  TabController _parentUserTabsController;
  final List<Tab> parentUserTabs = <Tab>[
    Tab(
        child: Text(
      'Notifications',
      textAlign: TextAlign.center,
    )),
    Tab(
        child: Text(
      'Meeting Requests',
      textAlign: TextAlign.center,
    )),
  ];
  TabController _teacherUserTabsController;
  final List<Tab> teacherUserTabs = <Tab>[
    Tab(
        child: Text(
      'Notifications',
      textAlign: TextAlign.center,
    )),
    Tab(
        child: Text(
      'Meeting Requests',
      textAlign: TextAlign.center,
    )),
    Tab(
        child: Text(
      'Connection Requests',
      textAlign: TextAlign.center,
    )),
  ];

  @override
  void initState() {
    super.initState();
    _parentUserTabsController =
        new TabController(length: parentUserTabs.length, vsync: this);
    _teacherUserTabsController =
        new TabController(length: teacherUserTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _parentUserTabsController.dispose();
    _teacherUserTabsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginTypeBloc, LoginType>(
      builder: (context, state) {
        if (state == LoginType.parent) {
          return Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TabBar(
                      tabs: parentUserTabs,
                      controller: this._parentUserTabsController,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          TabBarView(
                            controller: this._parentUserTabsController,
                            children: [
                              _NotificationsListTab(),
                              _MeetingRequestsListTab(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // BannerAdmob(),
              SizedBox(height: 5)
            ],
          );
        } else {
          return Column(
            children: [
              Expanded(
                  child: Column(
                children: [
                  TabBar(
                    tabs: teacherUserTabs,
                    controller: this._teacherUserTabsController,
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        TabBarView(
                          controller: this._teacherUserTabsController,
                          children: [
                            _NotificationsListTab(),
                            _MeetingRequestsListTab(),
                            _ConnectionRequestListTab(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              // BannerAdmob(),
              SizedBox(height: 5)
            ],
          );
        }
      },
    );
  }
}

class _NotificationsListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsListBloc, NotificationsListState>(
      builder: (context, state) {
        if (state is NotificationsListLoadSuccess) {
          var mainColumn = Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 22)),
              _HeaderRow(),
              const Padding(padding: EdgeInsets.only(top: 15)),
            ],
          );
          state.notifications.forEach((notification) {
            mainColumn.children.add(_NotificationListItem(notification));
          });
          return SingleChildScrollView(
            child: mainColumn,
          );
        } else {
          return Text('Invalid state type: ${state.runtimeType.toString()}');
        }
      },
    );
  }
}

class _MeetingRequestsListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsListBloc, NotificationsListState>(
      builder: (context, state) {
        if (state is NotificationsListLoadSuccess) {
          var mainColumn = Column(children: []);
          state.meetingRequests.forEach((request) {
            mainColumn.children.add(_MeetingRequestListItem(request));
          });
          return SingleChildScrollView(
            child: mainColumn,
          );
        } else {
          return Text('Invalid state type: ${state.runtimeType.toString()}');
        }
      },
    );
  }
}

class _ConnectionRequestListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsListBloc, NotificationsListState>(
      builder: (context, state) {
        if (state is NotificationsListLoadSuccess) {
          var mainColumn = Column(children: []);
          state.connectionRequests.forEach((request) {
            mainColumn.children.add(_ConnectionRequestListItem(request));
          });
          return SingleChildScrollView(
            child: mainColumn,
          );
        } else {
          return Text('Invalid state type: ${state.runtimeType.toString()}');
        }
      },
    );
  }
}

class _HeaderRow extends StatefulWidget {
  @override
  _HeaderRowState createState() => _HeaderRowState();
}

class _HeaderRowState extends State<_HeaderRow> {
  NotificationFilterType filterMenu = NotificationFilterType.all;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Notifications',
            style: TextStyle(
              color: PrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
          ),
          DropdownButton(
            value: filterMenu,
            iconEnabledColor: PrimaryColor,
            items: [
              DropdownMenuItem(
                child: Text(
                  'See all',
                  style: TextStyle(color: PrimaryColor),
                ),
                value: NotificationFilterType.all,
              ),
              DropdownMenuItem(
                child: Text(
                  'Seen',
                  style: TextStyle(color: PrimaryColor),
                ),
                value: NotificationFilterType.seen,
              ),
              DropdownMenuItem(
                child: Text(
                  'Unseen',
                  style: TextStyle(color: PrimaryColor),
                ),
                value: NotificationFilterType.unseen,
              ),
            ],
            onChanged: (NotificationFilterType value) {
              setState(() {
                context
                    .bloc<NotificationsListBloc>()
                    .add(NotificationsListLoaded(filterType: value));
                filterMenu = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

class _NotificationListItem extends StatelessWidget {
  _NotificationListItem(this.notification);

  final NotificationDto notification;

  final DateFormat _dateFormatter = DateFormat('yMMMEd');

  @override
  Widget build(BuildContext context) {
    try {
      DateTime.parse(notification.notifiedOn);
    } catch (e) {
      return Text('Error parsing date: ${notification.notifiedOn}');
    }
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 30),
      tileColor: !notification.seen ? AccentLightColor : Colors.transparent,
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: IconButton(
          icon: Icon(Icons.person, color: AccentColor),
          color: Colors.grey[200],
          disabledColor: Colors.grey[200],
          onPressed: () {},
        ),
      ),
      title: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            new TextSpan(
                text: notification.byUserName + ' ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            new TextSpan(
              text: notification.message,
            ),
          ],
        ),
      ),
      subtitle: Text(
        _dateFormatter
            .format(DateTime.parse(notification.notifiedOn))
            .toString(),
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}

class _MeetingRequestListItem extends StatelessWidget {
  final MeetingRequestDto meetingRequest;

  const _MeetingRequestListItem(this.meetingRequest);

  @override
  Widget build(BuildContext context) {
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
      title: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            new TextSpan(
                text: meetingRequest.requesterUserName + ' ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            new TextSpan(
              text: 'requested a meeting',
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MeetingApprovalScreen.route(meetingRequest));
      },
    );
  }
}

class _ConnectionRequestListItem extends StatelessWidget {
  final ParentTeacherConnectionRequestDto connectionRequest;

  const _ConnectionRequestListItem(this.connectionRequest);

  @override
  Widget build(BuildContext context) {
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
      title: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            new TextSpan(
                text: connectionRequest.parentUserName + ' ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            new TextSpan(
              text: 'requested to connect',
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .push(ConnectionApprovalScreen.route(connectionRequest));
      },
    );
  }
}
