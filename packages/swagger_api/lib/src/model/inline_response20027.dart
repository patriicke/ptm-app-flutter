part of '../api.dart';

class InlineResponse20027 {
  ApiResponse apiResponseMessage = null;

  Meeting data = null;

  InlineResponse20027();

  @override
  String toString() {
    return 'InlineResponse20027[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse20027.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = new Meeting.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse20027> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse20027>()
        : json.map((value) => new InlineResponse20027.fromJson(value)).toList();
  }

  static Map<String, InlineResponse20027> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse20027>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse20027.fromJson(value));
    }
    return map;
  }
}
