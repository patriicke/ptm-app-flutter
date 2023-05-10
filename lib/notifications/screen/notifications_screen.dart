import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/notifications/bloc/notifications_list/notifications_list_bloc.dart';
import 'package:meetings/notifications/screen/notifications_list.dart';
import 'package:repository_core/repository_core.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return NotificationsListBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
        )..add(NotificationsListLoaded());
      },
      child: NotificationsTab(),
    );
  }
}
