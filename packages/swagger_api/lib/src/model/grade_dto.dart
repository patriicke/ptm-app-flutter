part of '../api.dart';

class GradeDto {
  String gradeId = null;

  String gradeName = null;

  String gradeStatus = null;

  GradeDto();

  @override
  String toString() {
    return 'GradeDto[gradeId=$gradeId, gradeName=$gradeName, gradeStatus=$gradeStatus, ]';
  }

  GradeDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    gradeId = json['gradeId'];
    gradeName = json['gradeName'];
    gradeStatus = json['gradeStatus'];
  }

  Map<String, dynamic> toJson() {
    return {
      'gradeId': gradeId,
      'gradeName': gradeName,
      'gradeStatus': gradeStatus
    };
  }

  static List<GradeDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<GradeDto>()
        : json.map((value) => new GradeDto.fromJson(value)).toList();
  }

  static Map<String, GradeDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GradeDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new GradeDto.fromJson(value));
    }
    return map;
  }
}
