import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/blocs/login_type/login_type_bloc.dart';
import 'package:meetings/consts.dart';
import 'package:meetings/models/report.dart';
import 'package:meetings/reports/bloc/report_details/report_details_bloc.dart';
import 'package:meetings/reports/bloc/report_form/report_form_bloc.dart';
import 'package:meetings/reports/models/subject_grade.dart';
import 'package:repository_core/repository_core.dart';
import 'package:formz/formz.dart';

class ReportDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportDetailsBloc, ReportDetailsState>(
      listener: (context, listenerState) {
        if (listenerState is ReportDetailsLoadSuccess) {
          if (listenerState.feedbackFormStatus.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                      'Meeting Creation Failed: ${listenerState.formError}'),
                ),
              );
          } else if (listenerState.feedbackFormStatus.isSubmissionSuccess) {
            Navigator.pop(context);
          }
        }
      },
      child: BlocBuilder<LoginTypeBloc, LoginType>(
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        builder: (context, loginType) {
          return BlocBuilder<ReportDetailsBloc, ReportDetailsState>(
            builder: (context, builderState) {
              if (builderState is ReportDetailsLoadInProgress) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (builderState is ReportDetailsLoadSuccess) {
                var mainColumn = Column(
                  children: [
                    _StudentSummary(),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    _ReportContainer(),
                  ],
                );

                if (loginType == LoginType.parent) {
                  mainColumn.children.add(
                    const Padding(padding: EdgeInsets.only(top: 20)),
                  );
                  mainColumn.children.add(_ReactToReport());
                  mainColumn.children.add(
                    const Padding(padding: EdgeInsets.only(top: 20)),
                  );
                  mainColumn.children.add(_ParentCommentsInput());
                  mainColumn.children.add(
                    const Padding(padding: EdgeInsets.only(top: 20)),
                  );
                  mainColumn.children.add(_SendButton());
                  mainColumn.children.add(
                    const Padding(padding: EdgeInsets.only(top: 30)),
                  );
                }

                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: mainColumn,
                  ),
                );
              } else if (builderState is ReportDetailsLoadFailure) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(builderState.error),
                    TextButton(
                      onPressed: () {
                        context
                            .bloc<ReportDetailsBloc>()
                            .add(ReportDetailsLoaded());
                      },
                      child: Text('Reload'),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text('Invalid state type'),
                );
              }
            },
          );
        },
      ),
    );
  }
}

class _StudentSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportDetailsBloc, ReportDetailsState>(
      builder: (context, state) {
        if (state is ReportDetailsLoadSuccess) {
          print("report--${state.reportDetails}");
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Student Name',
                    style: TextStyle(
                      color: AccentColor,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  Text(
                    state.reportDetails.studentName,
                    style: TextStyle(
                      color: PrimaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Grade',
                    style: TextStyle(
                      color: AccentColor,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  state.reportDetails.studentGrade!=null?Text(
                    state.reportDetails.studentGrade,
                    style: TextStyle(
                      color: PrimaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ):Container(),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Teacher',
                    style: TextStyle(
                      color: AccentColor,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  Text(
                    state.reportDetails.teacherName,
                    style: TextStyle(
                      color: PrimaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return Text('Invalid state type');
        }
      },
    );
  }
}

class _ReportContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportDetailsBloc, ReportDetailsState>(
      builder: (context, state) {
        if (state is ReportDetailsLoadSuccess) {
          var subjectGradesWrap = Wrap(
            children: [],
            runSpacing: 23,
            alignment: WrapAlignment.center,
          );
          state.reportDetails.subjectGrades.forEach((subjectGrade) {
            subjectGradesWrap.children.add(_GradeContainer(
              subject: subjectGrade.subject,
              grade: subjectGrade.grade,
            ));
          });
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     _GradeContainer(
                  //       subject: 'Reading',
                  //       grade: state.reportDetails.readingMark,
                  //     ),
                  //     _GradeContainer(
                  //       subject: 'Writing',
                  //       grade: state.reportDetails.writingMark,
                  //     ),
                  //     _GradeContainer(
                  //       subject: 'Math',
                  //       grade: state.reportDetails.mathMark,
                  //     ),
                  //   ],
                  // ),
                  // const Padding(padding: EdgeInsets.only(top: 23)),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     _GradeContainer(
                  //       subject: 'Science',
                  //       grade: state.reportDetails.scienceMark,
                  //     ),
                  //     _GradeContainer(
                  //       subject: 'Social Std',
                  //       grade: state.reportDetails.socialStdMark,
                  //     ),
                  //     // _GradeContainer(
                  //     //   subject: 'Lorem',
                  //     //   grade: ReportGrade.c,
                  //     // ),
                  //   ],
                  // ),
                  Container(
                    width: double.infinity,
                    child: subjectGradesWrap,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  Text(
                    'Showing progress in',
                    style: TextStyle(
                      color: PrimaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 6)),
                  Text(
                    state.reportDetails.showingProgressIn,
                    style: TextStyle(
                      color: PrimaryColor,
                      fontSize: 14,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  Text(
                    'Something to work on',
                    style: TextStyle(
                      color: PrimaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 6)),
                  Text(
                    state.reportDetails.somethingToWorkOn,
                    style: TextStyle(
                      color: PrimaryColor,
                      fontSize: 14,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Teacher comments',
                          style: TextStyle(
                            color: PrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 6)),
                        Text(
                          state.reportDetails.teacherComments,
                          style: TextStyle(
                            color: PrimaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Text('Invalid report details state type');
        }
      },
    );
  }
}

class _GradeContainer extends StatelessWidget {
  const _GradeContainer({this.subject, this.grade});
  final String subject;
  final String grade;

  // String _gradeString(ReportGrade grade) {
  //   switch (grade) {
  //     case ReportGrade.aPlus:
  //       return 'A+';
  //     case ReportGrade.a:
  //       return 'A';
  //     case ReportGrade.bPlus:
  //       return 'B+';
  //     case ReportGrade.b:
  //       return 'B';
  //     case ReportGrade.cPlus:
  //       return 'C+';
  //     case ReportGrade.c:
  //       return 'C';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: 90,
      height: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            subject == null ? '' : subject,
            style: TextStyle(
              color: PrimaryColor,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 3)),
          Text(
            grade == null ? '' : subject,
            style: TextStyle(
              color: PrimaryColor,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

enum _ReportRating { lvl1, lvl2, lvl3, lvl4, lvl5, lvl6, lvl7 }

class _ReactToReport extends StatefulWidget {
  @override
  _ReactToReportState createState() => _ReactToReportState();
}

class _ReactToReportState extends State<_ReactToReport> {
  _ReportRating currentRating;
  List<Radio> generatedRatingOptions() {
    List<Radio> finalOptions = [];
    _ReportRating.values.forEach((rating) {
      finalOptions.add(
        Radio(
          value: rating,
          groupValue: currentRating,
          onChanged: (value) {
            setState(() {
              currentRating = value;
              context
                  .bloc<ReportDetailsBloc>()
                  .add(ParentRatingUpdated(currentRating.index));
            });
          },
          activeColor: PrimaryColor,
        ),
      );
    });

    return finalOptions;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'React to report',
          style: TextStyle(color: PrimaryColor, fontSize: 16.0),
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Row(
          children: generatedRatingOptions(),
        ),
      ],
    );
  }
}

class _ParentCommentsInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add comment',
          style: TextStyle(fontSize: 16, color: PrimaryColor),
        ),
        const Padding(padding: EdgeInsets.only(top: 5)),
        TextField(
          key: const Key('reactToReportForm_parentCommentsInput_textField'),
          onChanged: (parentComments) {
            context
                .bloc<ReportDetailsBloc>()
                .add(ParentCommentsUpdated(parentComments));
          },
          decoration: InputDecoration(
              // errorText: state.meetingTitle.errorText(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusColor: PrimaryColor,
              hoverColor: PrimaryColor,
              hintText: 'Add comment to report'),
        ),
      ],
    );
  }
}

class _SendButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportDetailsBloc, ReportDetailsState>(
      builder: (context, state) {
        if (state is ReportDetailsLoadSuccess) {
          return Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: PrimaryColor,
                textStyle: TextStyle(color: Colors.white, fontSize: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: const Text(
                  'Send',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              onPressed: state.feedbackFormStatus.isValidated &&
                      !state.feedbackFormStatus.isSubmissionInProgress
                  ? () {
                      context.bloc<ReportFormBloc>().add(ReportFormSubmitted());
                    }
                  : null,
            ),
          );
        } else {
          return Text('Invalid state type');
        }
      },
    );
  }
}
