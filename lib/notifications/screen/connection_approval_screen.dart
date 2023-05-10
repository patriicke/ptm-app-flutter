import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/notifications/bloc/connection/connection_bloc.dart';
import 'package:meetings/notifications/screen/connection_approval.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

class ConnectionApprovalScreen extends StatelessWidget {
  final ParentTeacherConnectionRequestDto connectionRequest;
  ConnectionApprovalScreen(this.connectionRequest);
  static Route route(ParentTeacherConnectionRequestDto connectionRequest) {
    return MaterialPageRoute<void>(
        builder: (_) => ConnectionApprovalScreen(connectionRequest));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: BlocProvider(
        create: (context) {
          return ConnectionBloc(
            connectionRequest: connectionRequest,
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          )..add(ConnectionLoaded());
        },
        child: ConnectionApproval(),
      ),
    );
  }
}
