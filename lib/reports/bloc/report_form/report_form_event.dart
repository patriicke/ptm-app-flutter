part of 'report_form_bloc.dart';

abstract class ReportFormEvent extends Equatable {
  const ReportFormEvent();

  @override
  List<Object> get props => [];
}

class ReportFormLoaded extends ReportFormEvent {
  const ReportFormLoaded();
}

class StudentNameUpdated extends ReportFormEvent {
  final String studentName;
  const StudentNameUpdated(this.studentName);

  @override
  List<Object> get props => [studentName];
}

class StudentSearchRequested extends ReportFormEvent {
  const StudentSearchRequested();
}

class StudentSelected extends ReportFormEvent {
  final String selectedStudentId;
  const StudentSelected(this.selectedStudentId);

  @override
  List<Object> get props => [selectedStudentId];
}

class StudentGradeUpdated extends ReportFormEvent {
  final String studentGrade;
  const StudentGradeUpdated(this.studentGrade);

  @override
  List<Object> get props => [studentGrade];
}

class ReadingGradeUpdated extends ReportFormEvent {
  final String readingGrade;
  const ReadingGradeUpdated(this.readingGrade);

  @override
  List<Object> get props => [readingGrade];
}

class WritingGradeUpdated extends ReportFormEvent {
  final String writingGrade;
  const WritingGradeUpdated(this.writingGrade);

  @override
  List<Object> get props => [writingGrade];
}

class MathGradeUpdated extends ReportFormEvent {
  final String mathGrade;
  const MathGradeUpdated(this.mathGrade);

  @override
  List<Object> get props => [mathGrade];
}

class ScienceGradeUpdated extends ReportFormEvent {
  final String scienceGrade;
  const ScienceGradeUpdated(this.scienceGrade);

  @override
  List<Object> get props => [scienceGrade];
}

class SocialStdGradeUpdated extends ReportFormEvent {
  final String socialStdGrade;
  const SocialStdGradeUpdated(this.socialStdGrade);

  @override
  List<Object> get props => [socialStdGrade];
}

class ShowingProgressInUpdated extends ReportFormEvent {
  final String showingProgressIn;
  const ShowingProgressInUpdated(this.showingProgressIn);

  @override
  List<Object> get props => [showingProgressIn];
}

class SomethingToWorkOnUpdated extends ReportFormEvent {
  final String somethingToWorkOn;
  const SomethingToWorkOnUpdated(this.somethingToWorkOn);

  @override
  List<Object> get props => [somethingToWorkOn];
}

class TeacherCommentsUpdated extends ReportFormEvent {
  final String teacherComments;
  const TeacherCommentsUpdated(this.teacherComments);

  @override
  List<Object> get props => [teacherComments];
}

class ReportFormSubmitted extends ReportFormEvent {
  const ReportFormSubmitted();
}

class SubjectGradeUpdated extends ReportFormEvent {
  final String subject;
  final String grade;

  const SubjectGradeUpdated(this.subject, this.grade);

  @override
  List<Object> get props => [subject, grade];
}
