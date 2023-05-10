import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/signup/bloc/connect_teacher/connect_teacher_bloc.dart';
import 'package:meetings/signup/screen/connect_teachers_form.dart';
import 'package:repository_core/repository_core.dart';

class ConnectTeachersScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ConnectTeachersScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/ff1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: BlocProvider<ConnectTeacherBloc>(
            child: ConnectTeachersForm(),
            create: (context) {
              return ConnectTeacherBloc(
                userRepository: RepositoryProvider.of<UserRepository>(context),
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
              )..add(ConnectTeacherLoaded());
            },
          ),
        ),
      ),
    );
  }
}
