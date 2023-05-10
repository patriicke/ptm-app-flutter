import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/login/bloc/login.dart';
import 'package:meetings/login/screen/login_form.dart';
import 'package:repository_core/repository_core.dart';

class LoginScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginScreen());
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
          child: BlocProvider(
            create: (context) {
              return LoginBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
              );
            },
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}
