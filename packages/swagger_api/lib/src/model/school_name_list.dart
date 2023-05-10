part of '../api.dart';

class SchoolNameList {
  String schoolId = null;

  String schoolName = null;

  SchoolNameList();

  @override
  String toString() {
    return 'StudentSearchResult[schoolId=$schoolId, schoolName=$schoolName, ]';
  }

  SchoolNameList.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    schoolId = json['studentId'];
    schoolName = json['schoolName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'schoolId': schoolId,
      'schoolName': schoolName
    };
  }

  static List<SchoolNameList> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<SchoolNameList>()
        : json.map((value) => new SchoolNameList.fromJson(value)).toList();
  }

  static Map<String, SchoolNameList> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SchoolNameList>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new SchoolNameList.fromJson(value));
    }
    return map;
  }
}
