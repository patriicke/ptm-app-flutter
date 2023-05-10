part of '../api.dart';

class SubjectDto {
  String subjectId = null;

  String subjectName = null;

  SubjectDto();

  @override
  String toString() {
    return 'SubjectDto[subjectId=$subjectId, subjectName=$subjectName, ]';
  }

  SubjectDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    subjectId = json['subjectId'];
    subjectName = json['subjectName'];
  }

  Map<String, dynamic> toJson() {
    return {'subjectId': subjectId, 'subjectName': subjectName};
  }

  static List<SubjectDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<SubjectDto>()
        : json.map((value) => new SubjectDto.fromJson(value)).toList();
  }

  static Map<String, SubjectDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SubjectDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new SubjectDto.fromJson(value));
    }
    return map;
  }
}
