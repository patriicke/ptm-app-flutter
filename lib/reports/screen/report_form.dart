
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/reports/bloc/report_form/report_form_bloc.dart';
import 'package:formz/formz.dart';

import '../../consts.dart';

class ReportForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportFormBloc, ReportFormState>(
      listener: (context, listenerState) {
        if (listenerState is ReportFormLoadSuccess) {
          if (listenerState.formStatus.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content:
                      Text('Meeting Creation Failed: ${listenerState.error}'),
                ),
              );
          } else if (listenerState.formStatus.isSubmissionSuccess) {
            Navigator.pop(context);
          }
        }
      },
      child: BlocBuilder<ReportFormBloc, ReportFormState>(
        builder: (context, state) {
          if (state is ReportFormLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ReportFormLoadSuccess) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FormTitle(),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  _StudentNameInput(),
                  // const Padding(padding: EdgeInsets.only(top: 20)),
                  // _StudentGradeInput(),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  _GradeInputsContainer(),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  _ShowingProgressInput(),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  _SomethingToWorkOnInput(),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  _TeacherCommentsInput(),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  _SendButton(),
                ],
              ),
            );
          } else if (state is ReportFormLoadFailure) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(state.error),
                TextButton(
                  onPressed: () {
                    context.bloc<ReportFormBloc>().add(ReportFormLoaded());
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
      ),
    );
  }
}

class _FormTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Create Report',
      style: TextStyle(
        color: PrimaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _StudentNameInput extends StatelessWidget {
  var _controller = TextEditingController();
  Widget _searchResultList(BuildContext context) {
    return BlocBuilder<ReportFormBloc, ReportFormState>(
      buildWhen: (previous, current) =>
          (previous as ReportFormLoadSuccess).searchedStudents !=
              (current as ReportFormLoadSuccess).searchedStudents ||
          (previous as ReportFormLoadSuccess).formStatus !=
              (current as ReportFormLoadSuccess).formStatus ||
          (previous as ReportFormLoadSuccess).searchStatus !=
              (current as ReportFormLoadSuccess).searchStatus,
      builder: (context, state) {
        if (state is ReportFormLoadSuccess) {
          return state.searchStatus.isSubmissionInProgress
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: state.searchedStudents.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      key: Key(
                          '__searched_teacher_${state.searchedStudents[index].studentId}__'),
                      title:
                          Text('${state.searchedStudents[index].studentName}'),
                      onTap: () {
                        context.bloc<ReportFormBloc>().add(
                              StudentSelected(
                                  state.searchedStudents[index].studentId),
                            );
                        Navigator.pop(context);
                      },
                    );
                  },
                );
        } else
          return Text('Invalid state type');
      },
    );
  }

  void _searchResultsBottomSheet(BuildContext context) {
    final provider = BlocProvider.of<ReportFormBloc>(context);
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            height: 300,
            child: BlocProvider.value(
              child: _searchResultList(context),
              value: provider,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportFormBloc, ReportFormState>(
      listenWhen: (previous, current) =>
          (previous as ReportFormLoadSuccess).searchStatus !=
              (current as ReportFormLoadSuccess).searchStatus ||
          (previous as ReportFormLoadSuccess).selectedStudent !=
              (current as ReportFormLoadSuccess).selectedStudent,
      listener: (context, listenerState) {
        if (listenerState is ReportFormLoadSuccess) {
          switch (listenerState.searchStatus) {
            case FormzStatus.submissionSuccess:
              _searchResultsBottomSheet(context);
              break;
            default:
          }
          if (listenerState.selectedStudent != null) {
            _controller.text = listenerState.selectedStudent.studentName;
          }
        }
      },
      child: BlocBuilder<ReportFormBloc, ReportFormState>(
        buildWhen: (previous, current) =>
            (previous as ReportFormLoadSuccess).selectedStudent !=
                (current as ReportFormLoadSuccess).selectedStudent ||
            (previous as ReportFormLoadSuccess).searchStatus !=
                (current as ReportFormLoadSuccess).searchStatus,
        builder: (context, builderState) {
          if (builderState is ReportFormLoadSuccess) {
            var mainColumn = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Student Name',
                  style: TextStyle(fontSize: 16, color: PrimaryColor),
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                TextField(
                  key: const Key('createReportForm_studentNameInput_textField'),
                  onChanged: (studentName) {
                    context
                        .bloc<ReportFormBloc>()
                        .add(StudentNameUpdated(studentName));
                  },
                  decoration: InputDecoration(
                    // errorText: state.meetingTitle.errorText(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusColor: PrimaryColor,
                    hoverColor: PrimaryColor,
                    suffixIcon: builderState.searchStatus.isSubmissionInProgress
                        ? Container(
                            padding: EdgeInsets.all(10.0),
                            child: CircularProgressIndicator(),
                          )
                        : IconButton(
                            icon: Icon(Icons.search),
                            onPressed:
                                builderState.studentNameSearchInput?.isEmpty ==
                                        true
                                    ? null
                                    : () {
                                        context
                                            .bloc<ReportFormBloc>()
                                            .add(StudentSearchRequested());
                                      },
                          ),
                  ),
                ),
              ],
            );
            if (builderState.selectedStudent != null) {
              mainColumn.children.add(const Padding(
                  padding: EdgeInsets.only(
                top: 5,
              )));
              mainColumn.children.add(
                  Text('${builderState.selectedStudent.studentName} selected'));
            }
            return mainColumn;
          } else
            return Text('Invalid state type');
        },
      ),
    );
  }
}

class _StudentGradeInput extends StatelessWidget {
  List<DropdownMenuItem> menuItems() {
    var menuItems = <DropdownMenuItem>[];

    for (var i = 1; i <= 12; i++) {
      menuItems.add(
        DropdownMenuItem(
          child: Text(
            'Grade ${i.toString()}',
            style: TextStyle(
              color: PrimaryColor,
            ),
          ),
          value: 'Grade ${i.toString()}',
        ),
      );
    }
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportFormBloc, ReportFormState>(
      builder: (context, state) {
        if (state is ReportFormLoadSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Grade',
                style: TextStyle(fontSize: 16, color: PrimaryColor),
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              DropdownButtonFormField(
                key: const Key('createReportForm_studentGradeInput_textField'),
                onChanged: (grade) {
                  context
                      .bloc<ReportFormBloc>()
                      .add(StudentGradeUpdated(grade));
                },
                iconEnabledColor: PrimaryColor,
                decoration: InputDecoration(
                  // errorText: state.meetingTitle.errorText(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusColor: PrimaryColor,
                  hoverColor: PrimaryColor,
                ),
                items: menuItems(),
              ),
            ],
          );
        } else
          return Text('Invalid state type');
      },
    );
  }
}

enum SubjectInputType { reading, writing, math, science, social_studies }

class _GradeInputsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportFormBloc, ReportFormState>(
      builder: (context, state) {
        if (state is ReportFormLoadSuccess) {
          var mainColumn = Column(
            children: [],
          );

          var gradeNames = state.grades.map((e) => e.gradeName).toList();

          state.subjectGrades.forEach((subjectGrade) {
            mainColumn.children.add(
                _SubjectGradeInputControl(subjectGrade.subject, gradeNames));
          });
          mainColumn.children
              .add(const Padding(padding: EdgeInsets.only(top: 20)));

          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 22),
            width: double.infinity,
            child: mainColumn,
          );
        } else
          return Text('Invalid state type');
      },
    );
  }
}

class _SubjectGradeInputControl extends StatelessWidget {
  const _SubjectGradeInputControl(
    this.subject,
    this.grades,
  );

  final String subject;
  final List<String> grades;

  List<DropdownMenuItem> menuItems() {
    var menuItems = <DropdownMenuItem>[];

    for (var grade in grades) {
      menuItems.add(
        DropdownMenuItem(
          child: Text(
            grade,
            style: TextStyle(
              color: PrimaryColor,
            ),
          ),
          value: grade,
        ),
      );
    }
    return menuItems;
  }

// TODO: DO NOT DELETE IN CASE YOU NEED TO REVERT TO OLD WORKFLOW!
  // String _getSubjectTitleString(SubjectInputType type) {
  //   switch (type) {
  //     case SubjectInputType.reading:
  //       return 'Reading';
  //     case SubjectInputType.writing:
  //       return 'Writing';
  //     case SubjectInputType.math:
  //       return 'Math';
  //     case SubjectInputType.science:
  //       return 'Science';
  //     case SubjectInputType.social_studies:
  //       return 'Social Studies';
  //   }
  //   return '';
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.only(top: 20)),
        Text(
          subject,
          style: TextStyle(fontSize: 16, color: PrimaryColor),
        ),
        const Padding(padding: EdgeInsets.only(top: 5)),
        DropdownButtonFormField(
          iconEnabledColor: PrimaryColor,
          decoration: InputDecoration(
            // errorText: state.meetingTitle.errorText(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusColor: PrimaryColor,
            hoverColor: PrimaryColor,
            fillColor: Colors.white,
            filled: true,
          ),
          items: menuItems(),
          onChanged: (value) {
            context
                .bloc<ReportFormBloc>()
                .add(SubjectGradeUpdated(subject, value));
            // TODO: DO NOT DELETE IN CASE YOU NEED TO REVERT TO OLD WORKFLOW!
            // final String paramValueString =
            //     value.toString().substring(value.toString().indexOf('.') + 1);
            // switch (subjectType) {
            //   case SubjectInputType.reading:
            //     context
            //         .bloc<ReportFormBloc>()
            //         .add(ReadingGradeUpdated(paramValueString));
            //     break;
            //   case SubjectInputType.writing:
            //     context
            //         .bloc<ReportFormBloc>()
            //         .add(WritingGradeUpdated(paramValueString));
            //     break;
            //   case SubjectInputType.math:
            //     context
            //         .bloc<ReportFormBloc>()
            //         .add(MathGradeUpdated(paramValueString));
            //     break;
            //   case SubjectInputType.science:
            //     context
            //         .bloc<ReportFormBloc>()
            //         .add(ScienceGradeUpdated(paramValueString));
            //     break;
            //   case SubjectInputType.social_studies:
            //     context
            //         .bloc<ReportFormBloc>()
            //         .add(SocialStdGradeUpdated(paramValueString));
            //     break;
            // }
          },
        ),
      ],
    );
  }
}

class _ShowingProgressInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportFormBloc, ReportFormState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Showing progress in',
              style: TextStyle(fontSize: 16, color: PrimaryColor),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            TextField(
              key: const Key('createReportForm_showingProgressInput_textField'),
              onChanged: (showingProgressIn) {
                context
                    .bloc<ReportFormBloc>()
                    .add(ShowingProgressInUpdated(showingProgressIn));
              },
              decoration: InputDecoration(
                // errorText: state.meetingTitle.errorText(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusColor: PrimaryColor,
                hoverColor: PrimaryColor,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SomethingToWorkOnInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Something to work on',
          style: TextStyle(fontSize: 16, color: PrimaryColor),
        ),
        const Padding(padding: EdgeInsets.only(top: 5)),
        TextField(
          key: const Key('createReportForm_toWorkOnInput_textField'),
          onChanged: (somethingToWorkOn) {
            context
                .bloc<ReportFormBloc>()
                .add(SomethingToWorkOnUpdated(somethingToWorkOn));
          },
          decoration: InputDecoration(
            // errorText: state.meetingTitle.errorText(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusColor: PrimaryColor,
            hoverColor: PrimaryColor,
          ),
        ),
      ],
    );
  }
}

class _TeacherCommentsInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Comments',
          style: TextStyle(fontSize: 16, color: PrimaryColor),
        ),
        const Padding(padding: EdgeInsets.only(top: 5)),
        TextField(
          key: const Key('createReportForm_teacherCommentsInput_textField'),
          keyboardType: TextInputType.multiline,
          minLines: 3,
          maxLines: 4,
          onChanged: (teacherComments) {
            context
                .bloc<ReportFormBloc>()
                .add(TeacherCommentsUpdated(teacherComments));
            context.bloc<ReportFormBloc>().add(StudentGradeUpdated('grade'));
          },
          decoration: InputDecoration(
              // errorText: state.meetingTitle.errorText(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusColor: PrimaryColor,
              hoverColor: PrimaryColor,
              hintText: 'Write comments here'),
        ),
      ],
    );
  }
}

class _SendButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportFormBloc, ReportFormState>(
      buildWhen: (previous, current) =>
          (previous as ReportFormLoadSuccess).formStatus !=
              (current as ReportFormLoadSuccess).formStatus ||
          (previous as ReportFormLoadSuccess).searchStatus !=
              (current as ReportFormLoadSuccess).searchStatus ||
          (previous as ReportFormLoadSuccess).selectedStudent !=
              (current as ReportFormLoadSuccess).selectedStudent,
      builder: (context, state) {
        if (state is ReportFormLoadSuccess) {
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
              onPressed: state.formStatus.isValidated &&
                      /* !state.searchStatus.isSubmissionInProgress && */
                      state.selectedStudent != null
                  ? () {
                      context.bloc<ReportFormBloc>().add(ReportFormSubmitted());
                    }
                  : null,
            ),
          );
        }
      },
    );
  }
}
