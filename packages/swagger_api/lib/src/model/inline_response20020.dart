part of '../api.dart';

class InlineResponse20020 {
  ApiResponse apiResponseMessage = null;

  InlineResponse20020Data data = null;

  InlineResponse20020();

  @override
  String toString() {
    return 'InlineResponse20020[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse20020.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = new InlineResponse20020Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse20020> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse20020>()
        : json.map((value) => new InlineResponse20020.fromJson(value)).toList();
  }

  static Map<String, InlineResponse20020> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse20020>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse20020.fromJson(value));
    }
    return map;
  }
}
