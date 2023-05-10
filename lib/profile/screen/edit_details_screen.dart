import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/profile/bloc/edit_details/edit_details_bloc.dart';
import 'package:meetings/profile/screen/edit_details_form.dart';
import 'package:repository_core/repository_core.dart';

class EditDetailsScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => EditDetailsScreen());
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
            return EditDetailsBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: EditDetailsForm(),
        ),
      ),
    );
  }
}
