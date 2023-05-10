import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/availability/bloc/availability_details/availability_details_bloc.dart';
import 'package:meetings/availability/screen/availability.dart';
import 'package:repository_core/repository_core.dart';

class AvailabilityDetailsScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => AvailabilityDetailsScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: BlocProvider(
        create: (context) {
          return AvailabilityDetailsBloc(
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          )..add(AvailabilityDetailsLoaded());
        },
        child: Availability(),
      ),
    );
  }
}
