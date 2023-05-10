import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/notifications/bloc/meeting_approval/meeting_approval_bloc.dart';
import 'package:meetings/notifications/screen/meeting_approval.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

class MeetingApprovalScreen extends StatelessWidget {
  final MeetingRequestDto meetingRequest;
  MeetingApprovalScreen(this.meetingRequest);
  static Route route(MeetingRequestDto meetingRequest) {
    return MaterialPageRoute<void>(
        builder: (_) => MeetingApprovalScreen(meetingRequest));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: BlocProvider(
        create: (context) {
          return MeetingApprovalBloc(
            meetingRequest: meetingRequest,
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          )..add(MeetingApprovalLoaded());
        },
        child: MeetingApproval(),
      ),
    );
  }
}
