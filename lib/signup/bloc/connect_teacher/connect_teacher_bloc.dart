import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meetings/signup/models/connect_teacher.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

part 'connect_teacher_event.dart';
part 'connect_teacher_state.dart';

class ConnectTeacherBloc
    extends Bloc<ConnectTeacherEvent, ConnectTeacherState> {
  ConnectTeacherBloc({
    @required UserRepository userRepository,
    @required AuthenticationRepository authenticationRepository,
  })  : assert(userRepository != null),
        assert(authenticationRepository != null),
        _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(ConnectTeacherLoadInProgress());

  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<ConnectTeacherState> mapEventToState(
    ConnectTeacherEvent event,
  ) async* {
    if (event is TeacherNameCodeUpdated) {
      yield* _mapTeacherNameCodeUpdatedToState(event, state);
    } else if (event is TeacherSubjectUpdated) {
      yield _mapTeacherSubjectUpdatedToState(event, state);
    } else if (event is ConnectTeacherSubmitted) {
      yield* _mapConnectTeacherSubmittedToState(event, state);
    } else if (event is NewTeacherAdded) {
      yield _mapNewTeacherAddedToState(event, state);
    } else if (event is TeacherSearchRequested) {
      yield* _mapTeacherSearchRequestedToState(event, state);
    } else if (event is ConnectTeacherLoaded) {
      yield* _mapConnectTeacherLoadedToState();
    }
  }

  Stream<ConnectTeacherState> _mapConnectTeacherLoadedToState() async* {
    yield ConnectTeacherLoadInProgress();

    try {
      var typesApi = TypesApi();
      var response = await typesApi.subjectPhpGet();

      if (response.apiResponseMessage.code != 200) {
        log('Exception when calling TypesApi->subjectPhpGet. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
        throw Exception(
            'Exception when calling TypesApi->subjectPhpGet. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
      }
      yield ConnectTeacherLoadSuccess(subjects: response.data);
    } catch (e) {
      yield ConnectTeacherLoadFailure(e.toString());
    }
  }

  Stream<ConnectTeacherState> _mapTeacherNameCodeUpdatedToState(
    TeacherNameCodeUpdated event,
    ConnectTeacherState state,
  ) async* {
    if (state is ConnectTeacherLoadSuccess) {
      final teacherNameCode = TeacherNameCode.dirty(event.teacherNameCode);
      yield state.copyWith(
        teacherNameCode: teacherNameCode,
        status: Formz.validate([
          teacherNameCode,
          state.teacherSubject,
        ]),
      );
    } else
      yield state;
  }

  ConnectTeacherState _mapTeacherSubjectUpdatedToState(
    TeacherSubjectUpdated event,
    ConnectTeacherState state,
  ) {
    if (state is ConnectTeacherLoadSuccess) {
      final teacherSubject = TeacherSubject.dirty(event.teacherSubject);
      return state.copyWith(
        teacherSubject: teacherSubject,
        status: Formz.validate([
          state.teacherNameCode,
          teacherSubject,
        ]),
      );
    } else
      return state;
  }

  Stream<ConnectTeacherState> _mapTeacherSearchRequestedToState(
    TeacherSearchRequested event,
    ConnectTeacherState state,
  ) async* {
    if (state is ConnectTeacherLoadSuccess) {
      if (state.status.isValidated) {
        yield state.copyWith(searchStatus: FormzStatus.submissionInProgress);
        try {
          var users = await _userRepository.searchTeachers(
              _authenticationRepository.authKey, state.teacherNameCode.value);
          if (users.length > 0) {
            yield state.copyWith(
                searchStatus: FormzStatus.submissionSuccess,
                searchedUsers: users);
          } else {
            yield state.copyWith(
              searchStatus: FormzStatus.submissionFailure,
              error: 'No users found',
            );
          }
        } catch (e) {
          yield state.copyWith(
            searchStatus: FormzStatus.submissionFailure,
            error: e.message,
          );
        }
      }
    } else
      yield state;
  }

  ConnectTeacherState _mapNewTeacherAddedToState(
    NewTeacherAdded event,
    ConnectTeacherState state,
  ) {
    // - Fetch user from searchedUsers that matches same ID as state.selectedUserId
    // - Create new Teacher using details from selected
    // - Create a copy of the state.teachers list
    // - Add the newly created temporary teacher to the teachers (copy) list
    // - Return a copy of the state with the teachers field replaced by the updated copy of teachers

    if (state is ConnectTeacherLoadSuccess) {
      if (!state.teachers
          .any((teacher) => teacher.id == event.selectedUserId)) {
        var selectedUser = state.searchedUsers
            .where((searchedUser) => searchedUser.id == event.selectedUserId)
            .first;
        var newTeacher = Teacher(
          id: selectedUser.id,
          name: selectedUser.name,
          subject: state.teacherSubject.value,
        );

        var updatedTeachers = List<Teacher>();
        state.teachers.forEach((teacher) {
          updatedTeachers.add(teacher);
        });
        updatedTeachers.add(newTeacher);

        return state.copyWith(
          teachers: updatedTeachers,
          searchStatus: FormzStatus.pure,
          searchedUsers: [],
        );
      } else
        return state;
    } else
      return state;
  }

  Stream<ConnectTeacherState> _mapConnectTeacherSubmittedToState(
    ConnectTeacherSubmitted event,
    ConnectTeacherState state,
  ) async* {
    // - Create a temporary list of ParentTeacherConnectionDto
    // - For each teacher in state.teachers add a new dto in temporary dto list
    // - Call _userRepository.registerParentTeacherConnections using the temporary dto list as a parameter
    // - Update form submission status based on response
    if (state is ConnectTeacherLoadSuccess) {
      if (state.status.isValidated) {
        yield state.copyWith(
          status: FormzStatus.submissionInProgress,
          searchStatus: FormzStatus.pure,
        );
        try {
          var connectionDtos = <ParentTeacherConnectionDto>[];
          state.teachers.forEach((teacher) {
            var newConnection = ParentTeacherConnectionDto();
            newConnection.teacherId = teacher.id;
            newConnection.subject = teacher.subject;
            connectionDtos.add(newConnection);
          });
          await _userRepository.registerParentTeacherConnections(
            _authenticationRepository.currentUser.id,
            _authenticationRepository.authKey,
            connectionDtos,
          );
          await _authenticationRepository
              .updateUserStatus(UserStatus.parentTeachersConnected);
          yield state.copyWith(
            teacherNameCode: TeacherNameCode.pure(),
            teacherSubject: TeacherSubject.pure(),
            teachers: state.teachers,
            status: FormzStatus.submissionSuccess,
            searchStatus: FormzStatus.pure,
          );
        } catch (e) {
          yield state.copyWith(
            status: FormzStatus.submissionFailure,
            searchStatus: FormzStatus.pure,
            error: e.toString(),
          );
        }
      }
    } else
      yield state;
  }
}
