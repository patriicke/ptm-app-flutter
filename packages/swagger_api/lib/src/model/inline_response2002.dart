part of '../api.dart';

class InlineResponse2002 {
  ApiResponse apiResponseMessage = null;

  List<SubjectDto> data = [];

  InlineResponse2002();

  @override
  String toString() {
    return 'InlineResponse2002[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse2002.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = SubjectDto.listFromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse2002> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse2002>()
        : json.map((value) => new InlineResponse2002.fromJson(value)).toList();
  }

  static Map<String, InlineResponse2002> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse2002>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse2002.fromJson(value));
    }
    return map;
  }
}
