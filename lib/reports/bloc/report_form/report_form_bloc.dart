import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meetings/reports/models/comments.dart';
import 'package:meetings/reports/models/showing_progress_in.dart';
import 'package:meetings/reports/models/sth_work_on.dart';
import 'package:meetings/reports/models/student_grade.dart';
import 'package:meetings/reports/models/subject_grade.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';

part 'report_form_event.dart';
part 'report_form_state.dart';

class ReportFormBloc extends Bloc<ReportFormEvent, ReportFormState> {
  ReportFormBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(ReportFormLoadInProgress());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<ReportFormState> mapEventToState(
    ReportFormEvent event,
  ) async* {
    if (event is StudentNameUpdated) {
      yield _mapStudentNameUpdatedToState(event, state);
    } else if (event is StudentSearchRequested) {
      yield* _mapStudentSearchRequestedToState(event, state);
    } else if (event is StudentSelected) {
      yield _mapStudentSelectedToState(event, state);
    } else if (event is StudentGradeUpdated) {
      yield _mapStudentGradeUpdatedToState(event, state);
    } else if (event is ReadingGradeUpdated) {
      yield _mapReadingGradeUpdatedToState(event, state);
    } else if (event is WritingGradeUpdated) {
      yield _mapWritingGradeUpdatedToState(event, state);
    } else if (event is MathGradeUpdated) {
      yield _mapMathGradeUpdatedToState(event, state);
    } else if (event is ScienceGradeUpdated) {
      yield _mapScienceGradeUpdatedToState(event, state);
    } else if (event is SocialStdGradeUpdated) {
      yield _mapSocialStdGradeUpdatedToState(event, state);
    } else if (event is ShowingProgressInUpdated) {
      yield _mapShowingProgressInUpdatedToState(event, state);
    } else if (event is SomethingToWorkOnUpdated) {
      yield _mapSomethingToWorkOnUpdatedToState(event, state);
    } else if (event is TeacherCommentsUpdated) {
      yield _mapTeacherCommentsUpdatedToState(event, state);
    } else if (event is ReportFormSubmitted) {
      yield* _mapReportFormSubmittedToState(event, state);
    } else if (event is ReportFormLoaded) {
      yield* _mapReportFormLoadedToState();
    } else if (event is SubjectGradeUpdated) {
      yield _mapSubjectGradeUpdatedToState(event, state);
    }
  }

  Stream<ReportFormState> _mapReportFormLoadedToState() async* {
    yield ReportFormLoadInProgress();

    try {
      var typesApi = TypesApi();
      var subjectsResponse = await typesApi.subjectPhpGet();

      if (subjectsResponse.apiResponseMessage.code != 200) {
        log('Exception when calling TypesApi->subjectPhpGet. code: ${subjectsResponse.apiResponseMessage.code}, message: ${subjectsResponse.apiResponseMessage.message}\n');
        throw Exception(
            'Exception when calling TypesApi->subjectPhpGet. code: ${subjectsResponse.apiResponseMessage.code}, message: ${subjectsResponse.apiResponseMessage.message}\n');
      }

      var gradesResponse = await typesApi.gradePhpGet();

      if (gradesResponse.apiResponseMessage.code != 200) {
        log('Exception when calling TypesApi->gradePhpGet. code: ${gradesResponse.apiResponseMessage.code}, message: ${gradesResponse.apiResponseMessage.message}\n');
        throw Exception(
            'Exception when calling TypesApi->gradePhpGet. code: ${gradesResponse.apiResponseMessage.code}, message: ${gradesResponse.apiResponseMessage.message}\n');
      }

      var reportGrades = subjectsResponse.data.map((subject) {
        return ReportSubjectGradeDto()..subject = subject.subjectName;
      }).toList();

      yield ReportFormLoadSuccess(
        subjects: subjectsResponse.data,
        grades: gradesResponse.data,
        subjectGrades: reportGrades,
      );
    } catch (e) {
      yield ReportFormLoadFailure(e.toString());
    }
  }

  ReportFormState _mapSubjectGradeUpdatedToState(
      SubjectGradeUpdated event, ReportFormState state) {
    if (state is ReportFormLoadSuccess) {
      var updatedSubjectGrades = state.subjectGrades.map((subjectGrade) {
        if (subjectGrade.subject == event.subject) {
          return ReportSubjectGradeDto()
            ..subject = event.subject
            ..grade = event.grade;
        } else
          return subjectGrade;
      }).toList();

      return state.copyWith(subjectGrades: updatedSubjectGrades);
    } else
      return state;
  }

  ReportFormState _mapStudentNameUpdatedToState(
      StudentNameUpdated event, ReportFormState state) {
    if (state is ReportFormLoadSuccess) {
      return state.copyWith(studentNameSearchInput: event.studentName);
    } else
      return state;
  }

  Stream<ReportFormState> _mapStudentSearchRequestedToState(
      StudentSearchRequested event, ReportFormState state) async* {
    if (state is ReportFormLoadSuccess) {
      yield state.copyWith(
        searchStatus: FormzStatus.submissionInProgress,
        error: null,
      );
      try {
        var reportApi = ReportApi();
        var authKey = _authenticationRepository.authKey;
        var response = await reportApi.studentsPhpGet(
          authKey,
          userName: state.studentNameSearchInput,
        );

        if (response.apiResponseMessage.code != 200) {
          log('Exception when calling ReportApi->studentsPhpGet. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
          throw Exception(
              'Exception when calling ReportApi->studentsPhpGet. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
        }
        yield state.copyWith(
          searchedStudents: response.data,
          searchStatus: FormzStatus.submissionSuccess,
          error: null,
        );
      } catch (e) {
        yield state.copyWith(
          searchStatus: FormzStatus.submissionFailure,
          error: e.toString(),
        );
      }
    } else
      yield state;
  }

  ReportFormState _mapStudentSelectedToState(
      StudentSelected event, ReportFormState state) {
    if (state is ReportFormLoadSuccess) {
      log(event.toString());
      var selectedStudent = state.searchedStudents
          .where((searchedStudent) =>
              searchedStudent.studentId == event.selectedStudentId)
          .first;
      if (selectedStudent != null) {
        return state.copyWith(
          selectedStudent: selectedStudent,
          searchStatus: FormzStatus.pure,
        );
      } else {
        return state;
      }
    } else
      return state;
  }

  ReportFormState _mapStudentGradeUpdatedToState(
      StudentGradeUpdated event, ReportFormState state) {
    if (state is ReportFormLoadSuccess) {
      final studentGrade = StudentGrade.dirty(event.studentGrade);
      return state.copyWith(
        grade: studentGrade,
        formStatus: Formz.validate([
          studentGrade,
          state.readingGrade,
          state.writingGrade,
          state.mathGrade,
          state.scienceGrade,
          state.socialStdGrade,
          state.showingProgressIn,
          state.somethingToWorkOn,
          state.teacherComments,
        ]),
      );
    } else
      return state;
  }

  ReportFormState _mapReadingGradeUpdatedToState(
      ReadingGradeUpdated event, ReportFormState state) {
    if (state is ReportFormLoadSuccess) {
      final readingGrade = SubjectGrade.dirty(event.readingGrade);
      return state.copyWith(
        readingGrade: readingGrade,
        formStatus: Formz.validate([
          state.grade,
          readingGrade,
          state.writingGrade,
          state.mathGrade,
          state.scienceGrade,
          state.socialStdGrade,
          state.showingProgressIn,
          state.somethingToWorkOn,
          state.teacherComments,
        ]),
      );
    } else
      return state;
  }

  ReportFormState _mapWritingGradeUpdatedToState(
      WritingGradeUpdated event, ReportFormState state) {
    if (state is ReportFormLoadSuccess) {
      final writingGrade = SubjectGrade.dirty(event.writingGrade);
      return state.copyWith(
        writingGrade: writingGrade,
        formStatus: Formz.validate([
          state.grade,
          state.readingGrade,
          writingGrade,
          state.mathGrade,
          state.scienceGrade,
          state.socialStdGrade,
          state.showingProgressIn,
          state.somethingToWorkOn,
          state.teacherComments,
        ]),
      );
    } else
      return state;
  }

  ReportFormState _mapMathGradeUpdatedToState(
      MathGradeUpdated event, ReportFormState state) {
    if (state is ReportFormLoadSuccess) {
      final mathGrade = SubjectGrade.dirty(event.mathGrade);
      return state.copyWith(
        mathGrade: mathGrade,
        formStatus: Formz.validate([
          state.grade,
          state.readingGrade,
          state.writingGrade,
          mathGrade,
          state.scienceGrade,
          state.socialStdGrade,
          state.showingProgressIn,
          state.somethingToWorkOn,
          state.teacherComments,
        ]),
      );
    } else
      return state;
  }

  ReportFormState _mapScienceGradeUpdatedToState(
      ScienceGradeUpdated event, ReportFormState state) {
    if (state is ReportFormLoadSuccess) {
      final scienceGrade = SubjectGrade.dirty(event.scienceGrade);
      return state.copyWith(
        scienceGrade: scienceGrade,
        formStatus: Formz.validate([
          state.grade,
          state.readingGrade,
          state.writingGrade,
          state.mathGrade,
          scienceGrade,
          state.socialStdGrade,
          state.showingProgressIn,
          state.somethingToWorkOn,
          state.teacherComments,
        ]),
      );
    } else
      return state;
  }

  ReportFormState _mapSocialStdGradeUpdatedToState(
      SocialStdGradeUpdated event, ReportFormState state) {
    if (state is ReportFormLoadSuccess) {
      final socialStdGrade = SubjectGrade.dirty(event.socialStdGrade);
      return state.copyWith(
        socialStdGrade: socialStdGrade,
        formStatus: Formz.validate([
          state.grade,
          state.readingGrade,
          state.writingGrade,
          state.mathGrade,
          state.scienceGrade,
          socialStdGrade,
          state.showingProgressIn,
          state.somethingToWorkOn,
          state.teacherComments,
        ]),
      );
    } else
      return state;
  }

  ReportFormState _mapShowingProgressInUpdatedToState(
      ShowingProgressInUpdated event, ReportFormState state) {
    if (state is ReportFormLoadSuccess) {
      final showingProgressIn =
          ShowingProgressIn.dirty(event.showingProgressIn);
      return state.copyWith(
        showingProgressIn: showingProgressIn,
        formStatus: Formz.validate([
          state.grade,
          state.readingGrade,
          state.writingGrade,
          state.mathGrade,
          state.scienceGrade,
          state.socialStdGrade,
          showingProgressIn,
          state.somethingToWorkOn,
          state.teacherComments,
        ]),
      );
    } else
      return state;
  }

  ReportFormState _mapSomethingToWorkOnUpdatedToState(
      SomethingToWorkOnUpdated event, ReportFormState state) {
    if (state is ReportFormLoadSuccess) {
      final somethingToWorkOn =
          SomethingToWorkOn.dirty(event.somethingToWorkOn);
      return state.copyWith(
        somethingToWorkOn: somethingToWorkOn,
        formStatus: Formz.validate([
          state.grade,
          state.readingGrade,
          state.writingGrade,
          state.mathGrade,
          state.scienceGrade,
          state.socialStdGrade,
          state.showingProgressIn,
          somethingToWorkOn,
          state.teacherComments,
        ]),
      );
    } else
      return state;
  }

  ReportFormState _mapTeacherCommentsUpdatedToState(
      TeacherCommentsUpdated event, ReportFormState state) {
    if (state is ReportFormLoadSuccess) {
      final teacherComments = Comments.dirty(event.teacherComments);
      return state.copyWith(
        teacherComments: teacherComments,
        formStatus: Formz.validate([
          state.grade,
          state.readingGrade,
          state.writingGrade,
          state.mathGrade,
          state.scienceGrade,
          state.socialStdGrade,
          state.showingProgressIn,
          state.somethingToWorkOn,
          teacherComments,
        ]),
      );
    } else
      return state;
  }

  Stream<ReportFormState> _mapReportFormSubmittedToState(
      ReportFormSubmitted event, ReportFormState state) async* {
    if (state is ReportFormLoadSuccess) {
      if (state.formStatus.isValidated) {
        yield state.copyWith(formStatus: FormzStatus.submissionInProgress);

        try {
          var reportApi = ReportApi();
          var authKey = _authenticationRepository.authKey;
          var vm = CreateEditReportVm()
            ..studentId = state.selectedStudent.studentId
            ..studentName = state.selectedStudent.studentName
            ..studentGrade = state.grade.value
            ..subjectGrades = state.subjectGrades
            ..readingMark = state.readingGrade.value
            ..writingMark = state.writingGrade.value
            ..mathMark = state.mathGrade.value
            ..scienceMark = state.scienceGrade.value
            ..socialStdMark = state.socialStdGrade.value
            ..showingProgressIn = state.showingProgressIn.value
            ..somethingToWorkOn = state.somethingToWorkOn.value
            ..teacherComments = state.teacherComments.value
            ..reportDate = DateTime.now().toIso8601String()
            ..teacherId = _authenticationRepository.currentUser.id;
          var response = await reportApi.createNewReport(authKey, vm);

          if (response.apiResponseMessage.code != 200) {
            log('Exception when calling ReportApi->createNewReport. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
            throw Exception(
                'Exception when calling ReportApi->createNewReport. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
          }
          yield state.copyWith(
            formStatus: FormzStatus.submissionSuccess,
            searchStatus: FormzStatus.pure,
            studentNameSearchInput: null,
            searchedStudents: const [],
            selectedStudent: null,
            grade: const StudentGrade.pure(),
            readingGrade: const SubjectGrade.pure(),
            writingGrade: const SubjectGrade.pure(),
            mathGrade: const SubjectGrade.pure(),
            scienceGrade: const SubjectGrade.pure(),
            socialStdGrade: const SubjectGrade.pure(),
            showingProgressIn: const ShowingProgressIn.pure(),
            somethingToWorkOn: const SomethingToWorkOn.pure(),
            teacherComments: const Comments.pure(),
          );
        } catch (e) {
          yield state.copyWith(
            formStatus: FormzStatus.submissionFailure,
            error: e.toString(),
          );
        }
      }
    } else
      yield state;
  }
}
