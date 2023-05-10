import 'package:equatable/equatable.dart';

enum ReportGrade {
  aPlus,
  a,
  bPlus,
  b,
  cPlus,
  c,
}

class Report extends Equatable {
  const Report({
    this.studentName,
    this.studentGrade,
    this.teacherName,
    this.readingGrade,
    this.writingGrade,
    this.mathGrade,
    this.scienceGrade,
    this.socialStdGrade,
    this.showingProgressIn,
    this.somethingToWorkOn,
    this.teacherComments,
    this.reportDate,
  });
  final String studentName;
  final String studentGrade;
  final String teacherName;
  final ReportGrade readingGrade;
  final ReportGrade writingGrade;
  final ReportGrade mathGrade;
  final ReportGrade scienceGrade;
  final ReportGrade socialStdGrade;
  final String showingProgressIn;
  final String somethingToWorkOn;
  final String teacherComments;
  final DateTime reportDate;

  Report copyWith({
    String studentName,
    String studentGrade,
    String teacherName,
    ReportGrade readingGrade,
    ReportGrade writingGrade,
    ReportGrade mathGrade,
    ReportGrade scienceGrade,
    ReportGrade socialStdGrade,
    String showingProgressIn,
    String somethingToWorkOn,
    String teacherComments,
    DateTime reportDate,
  }) {
    return Report(
      studentName: studentName ?? this.studentName,
      studentGrade: studentGrade ?? this.studentGrade,
      teacherName: teacherName ?? this.teacherName,
      readingGrade: readingGrade ?? this.readingGrade,
      writingGrade: writingGrade ?? this.writingGrade,
      mathGrade: mathGrade ?? this.mathGrade,
      scienceGrade: scienceGrade ?? this.scienceGrade,
      socialStdGrade: socialStdGrade ?? this.socialStdGrade,
      showingProgressIn: showingProgressIn ?? this.showingProgressIn,
      somethingToWorkOn: somethingToWorkOn ?? this.somethingToWorkOn,
      teacherComments: teacherComments ?? this.teacherComments,
      reportDate: reportDate ?? this.reportDate,
    );
  }

  @override
  List<Object> get props => [
        studentName,
        studentGrade,
        teacherName,
        readingGrade,
        writingGrade,
        mathGrade,
        scienceGrade,
        socialStdGrade,
        showingProgressIn,
        somethingToWorkOn,
        teacherComments,
        reportDate,
      ];
}
