part of '../api.dart';

class TeacherTellUsMoreVm {
  String schoolName = null;

  String schoolState = null;

  String schoolCity = null;

  String zipCode = null;

  TeacherTellUsMoreVm();

  @override
  String toString() {
    return 'TeacherTellUsMoreVm[schoolName=$schoolName, schoolState=$schoolState, schoolCity=$schoolCity, zipCode=$zipCode, ]';
  }

  TeacherTellUsMoreVm.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    schoolName = json['schoolName'];
    schoolState = json['schoolState'];
    schoolCity = json['schoolCity'];
    zipCode = json['zipCode'];
  }

  Map<String, dynamic> toJson() {
    return {
      'schoolName': schoolName,
      'schoolState': schoolState,
      'schoolCity': schoolCity,
      'zipCode': zipCode
    };
  }

  static List<TeacherTellUsMoreVm> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<TeacherTellUsMoreVm>()
        : json.map((value) => new TeacherTellUsMoreVm.fromJson(value)).toList();
  }

  static Map<String, TeacherTellUsMoreVm> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, TeacherTellUsMoreVm>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new TeacherTellUsMoreVm.fromJson(value));
    }
    return map;
  }
}
