import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/profile/bloc/user_profile/user_profile_bloc.dart';
import 'package:meetings/profile/screen/user_profile.dart';
import 'package:repository_core/repository_core.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return UserProfileBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
          userRepository: RepositoryProvider.of<UserRepository>(context),
        )..add(UserProfileLoaded());
      },
      child: UserProfile(),
    );
  }
}
