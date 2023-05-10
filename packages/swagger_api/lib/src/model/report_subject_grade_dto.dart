part of '../api.dart';

class ReportSubjectGradeDto {
  String subject = null;

  String grade = null;

  ReportSubjectGradeDto();

  @override
  String toString() {
    return 'ReportSubjectGradeDto[subject=$subject, grade=$grade, ]';
  }

  ReportSubjectGradeDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    subject = json['subject'];
    grade = json['grade'];
  }

  Map<String, dynamic> toJson() {
    return {'subject': subject, 'grade': grade};
  }

  static List<ReportSubjectGradeDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ReportSubjectGradeDto>()
        : json
            .map((value) => new ReportSubjectGradeDto.fromJson(value))
            .toList();
  }

  static Map<String, ReportSubjectGradeDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ReportSubjectGradeDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ReportSubjectGradeDto.fromJson(value));
    }
    return map;
  }
}
