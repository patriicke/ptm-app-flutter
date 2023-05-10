import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/profile/bloc/email_invite_form/email_invite_form_bloc.dart';
import 'package:meetings/profile/screen/email_invite_form.dart';
import 'package:repository_core/repository_core.dart';

class EmailInviteScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => EmailInviteScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: BlocProvider(
          create: (context) {
            return EmailInviteFormBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: EmailInviteForm(),
        ),
      ),
    );
  }
}
