import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/signup/bloc/tell_us_more/tell_us_more_bloc.dart';
import 'package:meetings/signup/screen/tell_us_more_form.dart';
import 'package:repository_core/repository_core.dart';

class TellUsMoreScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => TellUsMoreScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return TellUsMoreBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context),
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          )..add(TellUsMoreLoaded());
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/ff1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TellUsMoreForm(),
          ),
        ),
      ),
    );
  }
}
