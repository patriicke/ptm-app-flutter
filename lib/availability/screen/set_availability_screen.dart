import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/availability/bloc/availability_form/availability_form_bloc.dart';
import 'package:meetings/availability/screen/set_availability_form.dart';
import 'package:repository_core/repository_core.dart';

class SetAvailabilityScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SetAvailabilityScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: BlocProvider(
        create: (context) {
          return AvailabilityFormBloc(
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          );
        },
        child: SetAvailabilityForm(),
      ),
    );
  }
}
