part of 'connect_teacher_bloc.dart';

abstract class ConnectTeacherEvent extends Equatable {
  const ConnectTeacherEvent();

  @override
  List<Object> get props => [];
}

class ConnectTeacherLoaded extends ConnectTeacherEvent {
  const ConnectTeacherLoaded();
}

class TeacherNameCodeUpdated extends ConnectTeacherEvent {
  const TeacherNameCodeUpdated(this.teacherNameCode);
  final String teacherNameCode;

  @override
  List<Object> get props => [teacherNameCode];
}

class TeacherSubjectUpdated extends ConnectTeacherEvent {
  const TeacherSubjectUpdated(this.teacherSubject);
  final String teacherSubject;

  @override
  List<Object> get props => [teacherSubject];
}

class TeacherSearchRequested extends ConnectTeacherEvent {
  const TeacherSearchRequested();
}

class NewTeacherAdded extends ConnectTeacherEvent {
  const NewTeacherAdded(this.selectedUserId);
  final String selectedUserId;
}

class ConnectTeacherSubmitted extends ConnectTeacherEvent {
  const ConnectTeacherSubmitted();
}
