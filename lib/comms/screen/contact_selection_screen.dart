import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/comms/bloc/contact_selection/contact_selection_bloc.dart';
import 'package:meetings/comms/screen/contact_selection.dart';
import 'package:repository_core/repository_core.dart';

class ContactSelectionScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ContactSelectionScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: BlocProvider(
        create: (context) {
          return ContactSelectionBloc(
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          )..add(ContactSelectionLoaded());
        },
        child: ContactSelection(),
      ),
    );
  }
}
