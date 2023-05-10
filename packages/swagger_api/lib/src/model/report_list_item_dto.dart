part of '../api.dart';

class ReportListItemDto {
  String reportId = null;

  String reportDate = null;

  String studentName = null;

  String studentGrade = null;

  String parentComment = null;

  int parentRating = null;

  ReportListItemDto();

  @override
  String toString() {
    return 'ReportListItemDto[reportId=$reportId, reportDate=$reportDate, studentName=$studentName, studentGrade=$studentGrade, parentComment=$parentComment, parentRating=$parentRating, ]';
  }

  ReportListItemDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    reportId = json['reportId'];
    reportDate = json['reportDate'];
    studentName = json['studentName'];
    studentGrade = json['studentGrade'];
    parentComment = json['parentComment'];
    parentRating = json['parentRating'];
  }

  Map<String, dynamic> toJson() {
    return {
      'reportId': reportId,
      'reportDate': reportDate,
      'studentName': studentName,
      'studentGrade': studentGrade,
      'parentComment': parentComment,
      'parentRating': parentRating
    };
  }

  static List<ReportListItemDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ReportListItemDto>()
        : json.map((value) => new ReportListItemDto.fromJson(value)).toList();
  }

  static Map<String, ReportListItemDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ReportListItemDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ReportListItemDto.fromJson(value));
    }
    return map;
  }
}
