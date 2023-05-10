import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:meetings/signup/bloc/child_info/child_info_bloc.dart';
import 'package:meetings/signup/screen/connect_teachers_screen.dart';
import 'package:swagger_api/swagger_api.dart';

import '../../consts.dart';

class ChildInfoForm extends StatelessWidget {
  final headerTextStyle =
      TextStyle(color: PrimaryColor, fontSize: 18, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChildInfoBloc, ChildInfoState>(
      listener: (context, listenerState) {
        if (listenerState is ChildInfoLoadSuccess) {
          switch (listenerState.status) {
            case FormzStatus.submissionSuccess:
              Navigator.push(context, ConnectTeachersScreen.route());
              break;
            case FormzStatus.submissionFailure:
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('Submission failed'),
                  ),
                );
              break;
            default:
          }
        }
      },
      child: BlocBuilder<ChildInfoBloc, ChildInfoState>(
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        builder: (context, state) {
          if (state is ChildInfoLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ChildInfoLoadSuccess) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Align(
                          alignment: const Alignment(0, -1 / 3),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Padding(padding: EdgeInsets.only(top: 110)),
                              Text('Enter your child\'s information',
                                  style: headerTextStyle),
                              const Padding(padding: EdgeInsets.only(top: 45)),
                              _ChildInfoContainer(),
                              const Padding(padding: EdgeInsets.only(top: 25)),
                              _FullNameInput(),
                              const Padding(padding: EdgeInsets.only(top: 20)),
                              _StudentGradeInput(),
                              const Padding(padding: EdgeInsets.only(top: 20)),
                              _AddAnotherButton(),
                              const Padding(padding: EdgeInsets.only(top: 30)),
                              _DoneButton(),
                              const Padding(padding: EdgeInsets.only(top: 50)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is ChildInfoLoadFailure) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(state.error),
                TextButton(
                  onPressed: () {
                    context.bloc<ChildInfoBloc>().add(ChildInfoLoaded());
                  },
                  child: Text('Reload'),
                ),
              ],
            );
          } else
            return Center(
              child: Text('Invalid state type'),
            );
        },
      ),
    );
  }
}

class _AddAnotherButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildInfoBloc, ChildInfoState>(
      builder: (context, state) {
        if (state is ChildInfoLoadSuccess) {
          return TextButton(
            style: TextButton.styleFrom(
                backgroundColor: AccentLightColor
            ),
            onPressed: state.status.isSubmissionInProgress
                ? null
                : () {
                    context.bloc<ChildInfoBloc>().add(ChildAdded());
                  },
            child: Row(
              children: [
                Text(
                  'Add another',
                  style: TextStyle(color: PrimaryColor),
                ),
                Icon(
                  Icons.add,
                  color: PrimaryColor,
                )
              ],
            ),
          );
        } else {
          return Text('Invalid state type');
        }
      },
    );
  }
}

class _ChildInfoContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildInfoBloc, ChildInfoState>(
      buildWhen: (previous, current) =>
          (previous as ChildInfoLoadSuccess).children !=
          (current as ChildInfoLoadSuccess).children,
      builder: (context, state) {
        if (state is ChildInfoLoadSuccess) {
          var mainColumn = Column(children: []);
          state.children.forEach((child) {
            mainColumn.children.add(ListTile(
              tileColor: AccentColor,
              title: Text(
                child.name,
                style: TextStyle(
                  color: PrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              trailing: Text(
                child.grade,
                style: TextStyle(
                  color: PrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ));
          });
          return mainColumn;
        } else
          return Text('Invalid state type');
      },
    );
  }
}

class _FullNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildInfoBloc, ChildInfoState>(
      buildWhen: (previous, current) =>
          (previous as ChildInfoLoadSuccess).childName !=
          (current as ChildInfoLoadSuccess).childName,
      builder: (context, state) {
        if (state is ChildInfoLoadSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Name',
                style: TextStyle(fontSize: 16, color: PrimaryColor),
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              TextField(
                key: const Key('childInfoForm_fullNameInput_textField'),
                enabled: !state.status.isSubmissionInProgress,
                onChanged: (fullName) {
                  context.bloc<ChildInfoBloc>().add(ChildNameUpdated(fullName));
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusColor: PrimaryColor,
                  hoverColor: PrimaryColor,
                ),
              ),
            ],
          );
        } else
          return Text('Invalid state type');
      },
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
    return BlocBuilder<ChildInfoBloc, ChildInfoState>(
      buildWhen: (previous, current) =>
          (previous as ChildInfoLoadSuccess).childGrade !=
          (current as ChildInfoLoadSuccess).childGrade,
      builder: (context, state) {
        if (state is ChildInfoLoadSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Class',
                style: TextStyle(fontSize: 16, color: PrimaryColor),
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              DropdownButtonFormField(
                key: const Key('childInfoForm_gradeInput_textField'),
                onChanged: state.status.isSubmissionInProgress
                    ? null
                    : (grade) {
                        context
                            .bloc<ChildInfoBloc>()
                            .add(ChildGradeUpdated(grade));
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

class _DoneButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildInfoBloc, ChildInfoState>(
      builder: (context, state) {
        if (state is ChildInfoLoadSuccess) {
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
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              onPressed: state.status.isSubmissionInProgress
                  ? null
                  : () {
                      context.bloc<ChildInfoBloc>().add(ChildInfoSubmitted());
                    },
            ),
          );
        }
        return Text('Invalid state type');
      },
    );
  }
}
