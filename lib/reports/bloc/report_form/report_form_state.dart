part of 'report_form_bloc.dart';

abstract class ReportFormState extends Equatable {
  const ReportFormState();

  @override
  List<Object> get props => [];
}

class ReportFormLoadInProgress extends ReportFormState {}

class ReportFormLoadSuccess extends ReportFormState {
  final String studentNameSearchInput;
  final List<StudentSearchResult> searchedStudents;
  final StudentSearchResult selectedStudent;
  final FormzStatus searchStatus;
  final StudentGrade grade;
  final SubjectGrade readingGrade;
  final SubjectGrade writingGrade;
  final SubjectGrade mathGrade;
  final SubjectGrade scienceGrade;
  final SubjectGrade socialStdGrade;
  final ShowingProgressIn showingProgressIn;
  final SomethingToWorkOn somethingToWorkOn;
  final Comments teacherComments;
  final FormzStatus formStatus;
  final String error;

  final List<SubjectDto> subjects;
  final List<GradeDto> grades;
  final List<ReportSubjectGradeDto> subjectGrades;

  const ReportFormLoadSuccess({
    this.studentNameSearchInput,
    this.searchedStudents = const [],
    this.selectedStudent,
    this.searchStatus = FormzStatus.pure,
    this.grade = const StudentGrade.pure(),
    this.readingGrade = const SubjectGrade.pure(),
    this.writingGrade = const SubjectGrade.pure(),
    this.mathGrade = const SubjectGrade.pure(),
    this.scienceGrade = const SubjectGrade.pure(),
    this.socialStdGrade = const SubjectGrade.pure(),
    this.showingProgressIn = const ShowingProgressIn.pure(),
    this.somethingToWorkOn = const SomethingToWorkOn.pure(),
    this.teacherComments = const Comments.pure(),
    this.formStatus = FormzStatus.pure,
    this.error,
    this.subjects = const [],
    this.grades = const [],
    this.subjectGrades = const [],
  });

  ReportFormLoadSuccess copyWith({
    String studentNameSearchInput,
    List<StudentSearchResult> searchedStudents,
    StudentSearchResult selectedStudent,
    FormzStatus searchStatus,
    StudentGrade grade,
    SubjectGrade readingGrade,
    SubjectGrade writingGrade,
    SubjectGrade mathGrade,
    SubjectGrade scienceGrade,
    SubjectGrade socialStdGrade,
    ShowingProgressIn showingProgressIn,
    SomethingToWorkOn somethingToWorkOn,
    Comments teacherComments,
    FormzStatus formStatus,
    String error,
    List<SubjectDto> subjects,
    List<GradeDto> grades,
    List<ReportSubjectGradeDto> subjectGrades,
  }) {
    return ReportFormLoadSuccess(
      studentNameSearchInput:
          studentNameSearchInput ?? this.studentNameSearchInput,
      searchedStudents: searchedStudents ?? this.searchedStudents,
      selectedStudent: selectedStudent ?? this.selectedStudent,
      searchStatus: searchStatus ?? this.searchStatus,
      grade: grade ?? this.grade,
      readingGrade: readingGrade ?? this.readingGrade,
      writingGrade: writingGrade ?? this.writingGrade,
      mathGrade: mathGrade ?? this.mathGrade,
      scienceGrade: scienceGrade ?? this.scienceGrade,
      socialStdGrade: socialStdGrade ?? this.socialStdGrade,
      showingProgressIn: showingProgressIn ?? this.showingProgressIn,
      somethingToWorkOn: somethingToWorkOn ?? this.somethingToWorkOn,
      teacherComments: teacherComments ?? this.teacherComments,
      formStatus: formStatus ?? this.formStatus,
      error: error ?? this.error,
      subjects: subjects ?? this.subjects,
      grades: grades ?? this.grades,
      subjectGrades: subjectGrades ?? this.subjectGrades,
    );
  }

  @override
  List<Object> get props => [
        studentNameSearchInput,
        searchedStudents,
        selectedStudent,
        searchStatus,
        grade,
        readingGrade,
        writingGrade,
        mathGrade,
        scienceGrade,
        socialStdGrade,
        showingProgressIn,
        somethingToWorkOn,
        teacherComments,
        formStatus,
        error,
        subjects,
        grades,
        subjectGrades,
      ];
}

class ReportFormLoadFailure extends ReportFormState {
  final String error;

  const ReportFormLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
