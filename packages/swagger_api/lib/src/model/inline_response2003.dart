part of '../api.dart';

class InlineResponse2003 {
  ApiResponse apiResponseMessage = null;

  List<GradeDto> data = [];

  InlineResponse2003();

  @override
  String toString() {
    return 'InlineResponse2003[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse2003.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = GradeDto.listFromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse2003> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse2003>()
        : json.map((value) => new InlineResponse2003.fromJson(value)).toList();
  }

  static Map<String, InlineResponse2003> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse2003>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse2003.fromJson(value));
    }
    return map;
  }
}
