part of '../api.dart';

class ReportDetail {
  String reportId = null;

  String reportDate = null;

  String teacherId = null;

  String teacherName = null;

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

  String parentReportComment = null;

  int parentReportRating = null;
  //enum parentReportRatingEnum {  };
  ReportDetail();

  @override
  String toString() {
    return 'ReportDetail[reportId=$reportId, reportDate=$reportDate, teacherId=$teacherId, teacherName=$teacherName, studentId=$studentId, studentName=$studentName, studentGrade=$studentGrade, subjectGrades=$subjectGrades, readingMark=$readingMark, writingMark=$writingMark, mathMark=$mathMark, scienceMark=$scienceMark, socialStdMark=$socialStdMark, showingProgressIn=$showingProgressIn, somethingToWorkOn=$somethingToWorkOn, teacherComments=$teacherComments, parentReportComment=$parentReportComment, parentReportRating=$parentReportRating, ]';
  }

  ReportDetail.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    reportId = json['reportId'];
    reportDate = json['reportDate'];
    teacherId = json['teacherId'];
    teacherName = json['teacherName'];
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
    parentReportComment = json['parentReportComment'];
    parentReportRating = json['parentReportRating'];
  }

  Map<String, dynamic> toJson() {
    return {
      'reportId': reportId,
      'reportDate': reportDate,
      'teacherId': teacherId,
      'teacherName': teacherName,
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
      'teacherComments': teacherComments,
      'parentReportComment': parentReportComment,
      'parentReportRating': parentReportRating
    };
  }

  static List<ReportDetail> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ReportDetail>()
        : json.map((value) => new ReportDetail.fromJson(value)).toList();
  }

  static Map<String, ReportDetail> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ReportDetail>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ReportDetail.fromJson(value));
    }
    return map;
  }
}
