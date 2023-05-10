part of '../api.dart';

class CreateEditReportVm {
  String reportDate = null;

  String teacherId = null;

  String studentId = null;

  String studentName = null;

  String studentGrade = null;

  List<ReportSubjectGradeDto> subjectGrades = [];

  String readingMark = null;

  String writingMark = null;

  String mathMark = null;

  String scienceMark = null;

  String socialStdMark = null;

  String showingProgressIn = null;

  String somethingToWorkOn = null;

  String teacherComments = null;

  CreateEditReportVm();

  @override
  String toString() {
    return 'CreateEditReportVm[reportDate=$reportDate, teacherId=$teacherId, studentId=$studentId, studentName=$studentName, studentGrade=$studentGrade, subjectGrades=$subjectGrades, readingMark=$readingMark, writingMark=$writingMark, mathMark=$mathMark, scienceMark=$scienceMark, socialStdMark=$socialStdMark, showingProgressIn=$showingProgressIn, somethingToWorkOn=$somethingToWorkOn, teacherComments=$teacherComments, ]';
  }

  CreateEditReportVm.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    reportDate = json['reportDate'];
    teacherId = json['teacherId'];
    studentId = json['studentId'];
    studentName = json['studentName'];
    studentGrade = json['studentGrade'];
    subjectGrades = ReportSubjectGradeDto.listFromJson(json['subjectGrades']);
    readingMark = json['readingMark'];
    writingMark = json['writingMark'];
    mathMark = json['mathMark'];
    scienceMark = json['scienceMark'];
    socialStdMark = json['socialStdMark'];
    showingProgressIn = json['showingProgressIn'];
    somethingToWorkOn = json['somethingToWorkOn'];
    teacherComments = json['teacherComments'];
  }

  Map<String, dynamic> toJson() {
    return {
      'reportDate': reportDate,
      'teacherId': teacherId,
      'studentId': studentId,
      'studentName': studentName,
      'studentGrade': studentGrade,
      'subjectGrades': subjectGrades,
      'readingMark': readingMark,
      'writingMark': writingMark,
      'mathMark': mathMark,
      'scienceMark': scienceMark,
      'socialStdMark': socialStdMark,
      'showingProgressIn': showingProgressIn,
      'somethingToWorkOn': somethingToWorkOn,
      'teacherComments': teacherComments
    };
  }

  static List<CreateEditReportVm> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CreateEditReportVm>()
        : json.map((value) => new CreateEditReportVm.fromJson(value)).toList();
  }

  static Map<String, CreateEditReportVm> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateEditReportVm>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CreateEditReportVm.fromJson(value));
    }
    return map;
  }
}
