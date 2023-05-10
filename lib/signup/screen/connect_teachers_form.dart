import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/signup/bloc/connect_teacher/connect_teacher_bloc.dart';
import 'package:meetings/signup/screen/child_info_screen.dart';
import 'package:meetings/signup/screen/profile_completion_screen.dart';
import 'package:formz/formz.dart';
import 'package:swagger_api/swagger_api.dart';

import '../../consts.dart';

class ConnectTeachersForm extends StatefulWidget {
  @override
  _ConnectTeachersFormState createState() => _ConnectTeachersFormState();
}

class _ConnectTeachersFormState extends State<ConnectTeachersForm> {
  final headerTextStyle =
      TextStyle(color: PrimaryColor, fontSize: 18, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectTeacherBloc, ConnectTeacherState>(
      // listenWhen: (previous, current) =>
      //     (previous as ConnectTeacherLoadSuccess).status !=
      //         (current as ConnectTeacherLoadSuccess).status ||
      //     (previous as ConnectTeacherLoadSuccess).searchStatus !=
      //         (current as ConnectTeacherLoadSuccess).searchStatus,
      listener: (context, state) {
        if (state is ConnectTeacherLoadSuccess) {
          switch (state.status) {
            case FormzStatus.submissionFailure:
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text('Error: ${state.error}'),
                  ),
                );
              break;
            case FormzStatus.submissionSuccess:
              Navigator.push(context, ProfileCompletionScreen.route());
              break;
            default:
              break;
          }
          switch (state.searchStatus) {
            case FormzStatus.submissionFailure:
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text('Error: ${state.error}'),
                  ),
                );
              break;
            default:
              break;
          }
        }
      },
      child: BlocBuilder<ConnectTeacherBloc, ConnectTeacherState>(
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        builder: (context, state) {
          if (state is ConnectTeacherLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ConnectTeacherLoadSuccess) {
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
                              Text('Connect with child\'s teacher',
                                  style: headerTextStyle),
                              const Padding(padding: EdgeInsets.only(top: 45)),
                              _TeacherInfoContainer(),
                              const Padding(padding: EdgeInsets.only(top: 25)),
                              _TeacherNameInput(),
                              const Padding(padding: EdgeInsets.only(top: 20)),
                              _TeacherSubjectInput(),
                              const Padding(padding: EdgeInsets.only(top: 20)),
                              _AddTeacherButton(),
                              const Padding(padding: EdgeInsets.only(top: 30)),
                              // _SearchButton(),
                              // const Padding(padding: EdgeInsets.only(top: 20)),
                              _DoneButton(),
                              const Padding(padding: EdgeInsets.only(top: 50)),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 60.0,
                          left: -15,
                          child: IconButton(
                            icon: Icon(
                              Icons.chevron_left,
                              color: PrimaryColor,
                            ),
                            onPressed: () {
                              Navigator.push(context, ChildInfoScreen.route());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is ConnectTeacherLoadFailure) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(state.error),
                TextButton(
                  onPressed: () {
                    context
                        .bloc<ConnectTeacherBloc>()
                        .add(ConnectTeacherLoaded());
                  },
                  child: Text('Reload'),
                ),
              ],
            );
          } else
            return Center(child: Text('Invalid state type'));
        },
      ),
    );
  }
}

class _TeacherInfoContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectTeacherBloc, ConnectTeacherState>(
      buildWhen: (previous, current) =>
          (previous as ConnectTeacherLoadSuccess).teachers !=
          (current as ConnectTeacherLoadSuccess).teachers,
      builder: (context, state) {
        if (state is ConnectTeacherLoadSuccess) {
          var mainColumn = Column(children: []);
          state.teachers.forEach((teacher) {
            mainColumn.children.add(ListTile(
              tileColor: AccentColor,
              title: Text(
                teacher.name,
                style: TextStyle(
                  color: PrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              trailing: Text(
                teacher.subject,
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

class _TeacherNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectTeacherBloc, ConnectTeacherState>(
      buildWhen: (previous, current) =>
          (previous as ConnectTeacherLoadSuccess).status !=
              (current as ConnectTeacherLoadSuccess).status ||
          (previous as ConnectTeacherLoadSuccess).searchStatus !=
              (current as ConnectTeacherLoadSuccess).searchStatus ||
          (previous as ConnectTeacherLoadSuccess).teacherNameCode !=
              (current as ConnectTeacherLoadSuccess).teacherNameCode,
      builder: (context, state) {
        if (state is ConnectTeacherLoadSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Teacher',
                style: TextStyle(fontSize: 16, color: PrimaryColor),
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              Text('Press the \'Search Icon\' to find teachers'),
              const Padding(padding: EdgeInsets.only(top: 5)),
              TextField(
                key:
                    const Key('connectTeachersForm_teacherNameInput_textField'),
                onChanged: state.status.isSubmissionInProgress ||
                        state.searchStatus.isSubmissionInProgress
                    ? null
                    : (teacherName) {
                        context
                            .bloc<ConnectTeacherBloc>()
                            .add(TeacherNameCodeUpdated(teacherName));
                      },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusColor: PrimaryColor,
                  hoverColor: PrimaryColor,
                  suffixIcon: GestureDetector(
                    onTap: state.status.isSubmissionInProgress ||
                            state.searchStatus.isSubmissionInProgress
                        ? null
                        : () {
                            BlocProvider.of<ConnectTeacherBloc>(context)
                                .add(TeacherSearchRequested());
                          },
                    child: Icon(
                      Icons.search,
                      color: PrimaryColor,
                    ),
                  ),
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

class _TeacherSubjectInput extends StatelessWidget {
  List<DropdownMenuItem> menuItems(List<SubjectDto> subjects) {
    var menuItems = <DropdownMenuItem>[];
    subjects.forEach(
      (subject) {
        menuItems.add(
          DropdownMenuItem(
            child: Text(
              subject.subjectName,
              style: TextStyle(
                color: PrimaryColor,
              ),
            ),
            value: subject.subjectName,
          ),
        );
      },
    );
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectTeacherBloc, ConnectTeacherState>(
      buildWhen: (previous, current) =>
          (previous as ConnectTeacherLoadSuccess).teacherSubject !=
              (current as ConnectTeacherLoadSuccess).teacherSubject ||
          (previous as ConnectTeacherLoadSuccess).status !=
              (current as ConnectTeacherLoadSuccess).status ||
          (previous as ConnectTeacherLoadSuccess).searchStatus !=
              (current as ConnectTeacherLoadSuccess).searchStatus,
      builder: (context, state) {
        if (state is ConnectTeacherLoadSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Subject',
                style: TextStyle(fontSize: 16, color: PrimaryColor),
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              DropdownButtonFormField(
                key: const Key(
                    'connectTeachersForm_teacherSubjectInput_textField'),
                onChanged: state.status.isSubmissionInProgress ||
                        state.searchStatus.isSubmissionInProgress
                    ? null
                    : (subject) {
                        context
                            .bloc<ConnectTeacherBloc>()
                            .add(TeacherSubjectUpdated(subject));
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
                items: menuItems(state.subjects),
              ),
            ],
          );
        } else
          return Text('Invalid state type');
      },
    );
  }
}

class _AddTeacherButton extends StatelessWidget {
  Widget _searchResultList(BuildContext context) {
    return BlocBuilder<ConnectTeacherBloc, ConnectTeacherState>(
      buildWhen: (previous, current) =>
          (previous as ConnectTeacherLoadSuccess).searchedUsers !=
              (current as ConnectTeacherLoadSuccess).searchedUsers ||
          (previous as ConnectTeacherLoadSuccess).status !=
              (current as ConnectTeacherLoadSuccess).status ||
          (previous as ConnectTeacherLoadSuccess).searchStatus !=
              (current as ConnectTeacherLoadSuccess).searchStatus,
      builder: (context, state) {
        if (state is ConnectTeacherLoadSuccess) {
          return state.searchStatus.isSubmissionInProgress
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: state.searchedUsers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      key: Key(
                          '__searched_teacher_${state.searchedUsers[index].id}__'),
                      title: Text('${state.searchedUsers[index].name}'),
                      trailing: !state.teachers.any((teacher) =>
                              teacher.id == state.searchedUsers[index].id)
                          ? null
                          : Icon(
                              Icons.check,
                              color: PrimaryColor,
                            ),
                      onTap: () {
                        context.bloc<ConnectTeacherBloc>().add(
                            NewTeacherAdded(state.searchedUsers[index].id));
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
    final provider = BlocProvider.of<ConnectTeacherBloc>(context);
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: 300,
                  child: BlocProvider.value(
                    child: _searchResultList(context),
                    value: provider,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectTeacherBloc, ConnectTeacherState>(
      buildWhen: (previous, current) =>
          (previous as ConnectTeacherLoadSuccess).status !=
              (current as ConnectTeacherLoadSuccess).status ||
          (previous as ConnectTeacherLoadSuccess).searchStatus !=
              (current as ConnectTeacherLoadSuccess).searchStatus,
      builder: (context, state) {
        if (state is ConnectTeacherLoadSuccess) {
          return BlocListener<ConnectTeacherBloc, ConnectTeacherState>(
            listenWhen: (previous, current) =>
                (previous as ConnectTeacherLoadSuccess).searchStatus !=
                (current as ConnectTeacherLoadSuccess).searchStatus,
            listener: (context, state) {
              if (state is ConnectTeacherLoadSuccess) {
                switch (state.searchStatus) {
                  case FormzStatus.submissionSuccess:
                    _searchResultsBottomSheet(context);
                    break;
                  default:
                }
              }
            },
            // child: FlatButton(
            //   color: AccentLightColor,
            //   onPressed: state.status.isSubmissionInProgress ||
            //           state.searchStatus.isSubmissionInProgress
            //       ? null
            //       : () {
            //           BlocProvider.of<ConnectTeacherBloc>(context)
            //               .add(TeacherSearchRequested());
            //         },
            //   child: Row(
            //     children: [
            //       // Text(
            //       //   'Search another',
            //       //   style: TextStyle(color: PrimaryColor),
            //       // ),
            //       // Icon(
            //       //   Icons.add,
            //       //   color: PrimaryColor,
            //       // )
            //       Container(),
            //     ],
            //   ),
            // ),
            child: Container(),
          );
        } else
          return Text('Invalid state type');
      },
    );
  }
}

// class _SearchButton extends StatelessWidget {
//   Widget _searchResultList(BuildContext context) {
//     return BlocBuilder<ConnectTeacherBloc, ConnectTeacherState>(
//       buildWhen: (previous, current) =>
//           previous.searchedUsers != current.searchedUsers ||
//           previous.status != current.status ||
//           previous.searchStatus != current.searchStatus,
//       builder: (context, state) {
//         return state.searchStatus.isSubmissionInProgress
//             ? CircularProgressIndicator()
//             : ListView.builder(
//                 itemCount: state.searchedUsers.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     key: Key(
//                         '__searched_teacher_${state.searchedUsers[index].id}__'),
//                     title: Text('${state.searchedUsers[index].name}'),
//                     trailing: !state.teachers.any((teacher) =>
//                             teacher.id == state.searchedUsers[index].id)
//                         ? null
//                         : Icon(
//                             Icons.check,
//                             color: PrimaryColor,
//                           ),
//                     onTap: () {
//                       context
//                           .bloc<ConnectTeacherBloc>()
//                           .add(NewTeacherAdded(state.searchedUsers[index].id));
//                       Navigator.pop(context);
//                     },
//                   );
//                 },
//               );
//       },
//     );
//   }

//   void _searchResultsBottomSheet(BuildContext context) {
//     final provider = BlocProvider.of<ConnectTeacherBloc>(context);
//     showModalBottomSheet(
//       context: context,
//       useRootNavigator: true,
//       builder: (BuildContext context) {
//         return SingleChildScrollView(
//           child: Container(
//             height: 300,
//             child: BlocProvider.value(
//               child: _searchResultList(context),
//               value: provider,
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ConnectTeacherBloc, ConnectTeacherState>(
//       buildWhen: (previous, current) =>
//           previous.status != current.status ||
//           previous.searchStatus != current.searchStatus,
//       builder: (context, state) {
//         return BlocListener<ConnectTeacherBloc, ConnectTeacherState>(
//           listener: (context, state) {
//             switch (state.searchStatus) {
//               case FormzStatus.submissionSuccess:
//                 _searchResultsBottomSheet(context);
//                 break;
//               default:
//             }
//           },
//           child: Container(
//             width: double.infinity,
//             child: RaisedButton(
//               color: PrimaryColor,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0)),
//               padding: EdgeInsets.symmetric(vertical: 15.0),
//               onPressed: state.status.isSubmissionInProgress ||
//                       state.searchStatus.isSubmissionInProgress
//                   ? null
//                   : () {
//                       BlocProvider.of<ConnectTeacherBloc>(context)
//                           .add(TeacherSearchRequested());
//                     },
//               child: Text(
//                 'Search',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class _DoneButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectTeacherBloc, ConnectTeacherState>(
      buildWhen: (previous, current) =>
          (previous as ConnectTeacherLoadSuccess).status !=
              (current as ConnectTeacherLoadSuccess).status ||
          (previous as ConnectTeacherLoadSuccess).searchStatus !=
              (current as ConnectTeacherLoadSuccess).searchStatus,
      builder: (context, state) {
        if (state is ConnectTeacherLoadSuccess) {
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
              onPressed: state.status.isSubmissionInProgress ||
                      state.searchStatus.isSubmissionInProgress
                  ? null
                  : () {
                      context
                          .bloc<ConnectTeacherBloc>()
                          .add(ConnectTeacherSubmitted());
                    },
            ),
          );
        } else
          return Text('Invalid state type');
      },
    );
  }
}
