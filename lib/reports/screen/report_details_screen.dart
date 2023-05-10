import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/reports/bloc/report_details/report_details_bloc.dart';
import 'package:meetings/reports/screen/report_details.dart';
import 'package:repository_core/repository_core.dart';

class ReportDetailsScreen extends StatelessWidget {
  final String reportId;
  ReportDetailsScreen(this.reportId);
  static Route route(String reportId) {
    return MaterialPageRoute<void>(
        builder: (_) => ReportDetailsScreen(reportId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: BlocProvider(
        create: (context) {
          return ReportDetailsBloc(
            reportId: reportId,
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          )..add(ReportDetailsLoaded());
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: ReportDetails(),
        ),
      ),
    );
  }
}
