import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/blocs/login_type/login_type_bloc.dart';
import 'package:meetings/consts.dart';
import 'package:intl/intl.dart';
import 'package:meetings/reports/bloc/report_list/report_list_bloc.dart';
import 'package:meetings/reports/screen/report_details_screen.dart';
import 'package:meetings/reports/screen/report_form_screen.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

import '../../bannerads.dart';

class ReportList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginTypeBloc, LoginType>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, loginType) {
        return BlocBuilder<ReportListBloc, ReportListState>(
          builder: (context, state) {
            if (state is ReportListLoadInProgress) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ReportListLoadSuccess) {
              var mainColumn = Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  _HeaderRow(),
                ],
              );
              state.reports.forEach((report) {
                return mainColumn.children.add(_ReportCard(report));
              });
              var mainStack = Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Expanded(
                            child: SingleChildScrollView(child: mainColumn)),
                      ],
                    ),
                  ),
                ],
              );
              if (loginType == LoginType.teacher) {
                mainStack.children.add(
                  Positioned(
                    child: FloatingActionButton(
                      backgroundColor: PrimaryColor,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(CreateReportScreen.route());
                      },
                    ),
                    bottom: 16,
                    right: 16,
                  ),
                );
              }
              return Column(
                children: [
                  Expanded(child: mainStack),
                  // BannerAdmob(),
                  SizedBox(height: 5)
                ],
              );
            } else if (state is ReportListLoadFailure) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(state.error),
                  TextButton(
                    onPressed: () {
                      context.bloc<ReportListBloc>().add(ReportListLoaded());
                    },
                    child: Text('Reload'),
                  ),
                ],
              );
            } else {
              return Center(child: Text('Invalid report list state type'));
            }
          },
        );
      },
    );
  }
}

class _HeaderRow extends StatefulWidget {
  @override
  _HeaderRowState createState() => _HeaderRowState();
}

class _HeaderRowState extends State<_HeaderRow> {
  int filterMenu = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Reports',
          style: TextStyle(
            color: PrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        ),
        DropdownButton(
          value: filterMenu,
          iconEnabledColor: PrimaryColor,
          items: [
            DropdownMenuItem(
              child: Text(
                'See all',
                style: TextStyle(color: PrimaryColor),
              ),
              value: 1,
            ),
          ],
          onChanged: (value) {
            setState(() {
              filterMenu = value;
            });
          },
        ),
      ],
    );
  }
}

class _ReportCard extends StatelessWidget {
  _ReportCard(this.report);
  final ReportListItemDto report;
  final DateFormat dateFormatter = DateFormat('yMMMEd');

  @override
  Widget build(BuildContext context) {
    try {
      DateTime.parse(report.reportDate);
    } catch (e) {
      return Text(
          'Invalid report date for report { id: ${report.reportId}, date: ${report.reportDate}}');
    }
    var cardColumn = Column(
      children: [
        ListTile(
          tileColor: report.parentComment == null
              ? ListTileTheme.of(context).tileColor
              : Colors.grey[100],
          title: Text(
            report.studentName,
            style: TextStyle(
              color: PrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          subtitle: Text(
            report.studentGrade != null ? report.studentGrade : '-',
            style: TextStyle(
              fontSize: 14.0,
              color: AccentColor,
            ),
          ),
          trailing: CircleAvatar(
            backgroundColor:
                report.parentComment == null ? Colors.grey[300] : Colors.white,
            child: IconButton(
              icon: Icon(Icons.person, color: AccentColor),
              color: Colors.grey[200],
              disabledColor: Colors.grey[200],
              onPressed: () {},
            ),
          ),
        ),
        ListTile(
          tileColor: report.parentComment == null
              ? ListTileTheme.of(context).tileColor
              : Colors.grey[100],
          title: Text(
            dateFormatter.format(DateTime.parse(report.reportDate)).toString(),
            style: TextStyle(
              color: PrimaryColor,
              fontSize: 15.0,
            ),
          ),
        )
      ],
    );

    if (report.parentComment != null) {
      cardColumn.children.add(
        ListTile(
          tileColor: report.parentComment == null
              ? ListTileTheme.of(context).tileColor
              : Colors.grey[300],
          title: Text(
            report.parentComment,
            style: TextStyle(
              color: PrimaryColor,
            ),
          ),
          trailing: Icon(
            Icons.sentiment_satisfied_alt,
            color: PrimaryColor,
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.only(top: 30)),
        Text(
          dateFormatter.format(DateTime.parse(report.reportDate)).toString(),
          style: TextStyle(color: PrimaryColor),
        ),
        const Padding(padding: EdgeInsets.only(top: 5.0)),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(ReportDetailsScreen.route(report.reportId));
          },
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.0, color: AccentColor),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              child: cardColumn,
            ),
          ),
        ),
      ],
    );
  }
}
