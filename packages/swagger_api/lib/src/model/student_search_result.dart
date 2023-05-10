part of '../api.dart';

class StudentSearchResult {
  String studentId = null;

  String studentName = null;

  String studentGrade = null;

  StudentSearchResult();

  @override
  String toString() {
    return 'StudentSearchResult[studentId=$studentId, studentName=$studentName, studentGrade=$studentGrade, ]';
  }

  StudentSearchResult.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    studentId = json['studentId'];
    studentName = json['studentName'];
    studentGrade = json['studentGrade'];
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'studentName': studentName,
      'studentGrade': studentGrade
    };
  }

  static List<StudentSearchResult> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<StudentSearchResult>()
        : json.map((value) => new StudentSearchResult.fromJson(value)).toList();
  }

  static Map<String, StudentSearchResult> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StudentSearchResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new StudentSearchResult.fromJson(value));
    }
    return map;
  }
}
