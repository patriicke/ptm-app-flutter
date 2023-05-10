import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/signup/bloc/child_info/child_info_bloc.dart';
import 'package:meetings/signup/screen/child_info_form.dart';
import 'package:repository_core/repository_core.dart';

class ChildInfoScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ChildInfoScreen());
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
          child: BlocProvider<ChildInfoBloc>(
            child: ChildInfoForm(),
            create: (context) {
              return ChildInfoBloc(
                userRepository: RepositoryProvider.of<UserRepository>(context),
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
              )..add(ChildInfoLoaded());
            },
          ),
        ),
      ),
    );
  }
}
