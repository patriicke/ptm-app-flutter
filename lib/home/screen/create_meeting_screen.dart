import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/home/bloc/meeting_request/meeting_request_bloc.dart';
import 'package:meetings/home/screen/create_meeting_form.dart';
import 'package:meetings/landing/screen/landing_screen.dart';
import 'package:repository_core/repository_core.dart';

class CreateMeetingScreen extends StatelessWidget {
  final String preselectedUserId;
  final String preselectedUserName;
  final int preslectedUserType;

  const CreateMeetingScreen({
    this.preselectedUserId,
    this.preselectedUserName,
    this.preslectedUserType,
  });

  static Route route({
    String preselectedUserId,
    String preselectedUserName,
    int preselectedUserType,
  }) {
    return MaterialPageRoute<void>(
        builder: (_) => CreateMeetingScreen(
              preselectedUserId: preselectedUserId,
              preselectedUserName: preselectedUserName,
              preslectedUserType: preselectedUserType,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.of(context).pushReplacement(LandingScreenNew.route()),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: BlocProvider(
          create: (context) {
            if (preselectedUserId == null) {
              return MeetingRequestBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
                meetingRepository:
                    RepositoryProvider.of<MeetingsRepository>(context),
                userRepository: RepositoryProvider.of<UserRepository>(context),
              );
            } else {
              return MeetingRequestBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
                meetingRepository:
                    RepositoryProvider.of<MeetingsRepository>(context),
                userRepository: RepositoryProvider.of<UserRepository>(context),
              )..add(RecipientPreselected(
                  preselectedUserId, preselectedUserName, preslectedUserType));
            }
          },
          child: CreateMeetingForm(),
        ),
      ),
    );
  }
}
