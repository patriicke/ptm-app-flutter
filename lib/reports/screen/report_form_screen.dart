import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/reports/bloc/report_form/report_form_bloc.dart';
import 'package:meetings/reports/screen/report_form.dart';
import 'package:repository_core/repository_core.dart';

class CreateReportScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CreateReportScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: BlocProvider(
        create: (context) {
          return ReportFormBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context))
            ..add(ReportFormLoaded());
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 24),
          child: ReportForm(),
        ),
      ),
    );
  }
}
