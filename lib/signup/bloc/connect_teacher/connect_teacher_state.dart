part of 'connect_teacher_bloc.dart';

abstract class ConnectTeacherState extends Equatable {
  const ConnectTeacherState();

  @override
  List<Object> get props => [];
}

class ConnectTeacherLoadInProgress extends ConnectTeacherState {}

class ConnectTeacherLoadSuccess extends ConnectTeacherState {
  final FormzStatus status;
  final List<Teacher> teachers;
  final TeacherNameCode teacherNameCode;
  final TeacherSubject teacherSubject;
  final String error;

  final List<UserSearchResultDto> searchedUsers;
  final FormzStatus searchStatus;

  final List<SubjectDto> subjects;

  const ConnectTeacherLoadSuccess({
    this.status = FormzStatus.pure,
    this.searchStatus = FormzStatus.pure,
    this.teachers = const [],
    this.teacherNameCode = const TeacherNameCode.pure(),
    this.teacherSubject = const TeacherSubject.pure(),
    this.searchedUsers,
    this.error,
    this.subjects = const [],
  });

  ConnectTeacherLoadSuccess copyWith(
      {FormzStatus status,
      FormzStatus searchStatus,
      List<Teacher> teachers,
      TeacherNameCode teacherNameCode,
      TeacherSubject teacherSubject,
      List<UserSearchResultDto> searchedUsers,
      String error,
      List<SubjectDto> subjects}) {
    return ConnectTeacherLoadSuccess(
      status: status ?? this.status,
      searchStatus: searchStatus ?? this.searchStatus,
      teachers: teachers ?? this.teachers,
      teacherNameCode: teacherNameCode ?? this.teacherNameCode,
      teacherSubject: teacherSubject ?? this.teacherSubject,
      searchedUsers: searchedUsers ?? this.searchedUsers,
      error: error ?? this.error,
      subjects: subjects ?? this.subjects,
    );
  }

  @override
  List<Object> get props => [
        status,
        searchStatus,
        teachers,
        teacherNameCode,
        teacherSubject,
        searchedUsers,
        error,
        subjects,
      ];
}

class ConnectTeacherLoadFailure extends ConnectTeacherState {
  final String error;

  ConnectTeacherLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
