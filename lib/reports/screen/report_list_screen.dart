import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/reports/bloc/report_list/report_list_bloc.dart';
import 'package:meetings/reports/screen/report_list.dart';
import 'package:repository_core/repository_core.dart';

class ReportListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ReportListBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
        )..add(ReportListLoaded());
      },
      child: ReportList(),
    );
  }
}
