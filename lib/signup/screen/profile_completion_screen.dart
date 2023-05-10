import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/signup/bloc/profile_completion/profile_completion_bloc.dart';
import 'package:meetings/signup/screen/profile_completion_form.dart';
import 'package:repository_core/repository_core.dart';

class ProfileCompletionScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ProfileCompletionScreen());
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
              return ProfileCompletionBloc(
                userRepository: RepositoryProvider.of<UserRepository>(context),
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
              );
            },
            child: ProfileCompletionForm(),
          ),
        ),
      ),
    );
  }
}
