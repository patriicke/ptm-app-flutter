part of '../api.dart';

class ParentTeacherConnectionDto {
  String teacherId = null;

  String subject = null;
  //enum subjectEnum {  Reading,  Writing,  Math,  Science,  SocialStd,  };
  ParentTeacherConnectionDto();

  @override
  String toString() {
    return 'ParentTeacherConnectionDto[teacherId=$teacherId, subject=$subject, ]';
  }

  ParentTeacherConnectionDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    teacherId = json['teacherId'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    return {'teacherId': teacherId, 'subject': subject};
  }

  static List<ParentTeacherConnectionDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ParentTeacherConnectionDto>()
        : json
            .map((value) => new ParentTeacherConnectionDto.fromJson(value))
            .toList();
  }

  static Map<String, ParentTeacherConnectionDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ParentTeacherConnectionDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ParentTeacherConnectionDto.fromJson(value));
    }
    return map;
  }
}
