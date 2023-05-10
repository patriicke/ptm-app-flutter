part of '../api.dart';

class InlineResponse2001 {
  ApiResponse apiResponseMessage = null;

  InlineResponse2001();

  @override
  String toString() {
    return 'InlineResponse2001[apiResponseMessage=$apiResponseMessage, ]';
  }

  InlineResponse2001.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage};
  }

  static List<InlineResponse2001> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse2001>()
        : json.map((value) => new InlineResponse2001.fromJson(value)).toList();
  }

  static Map<String, InlineResponse2001> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse2001>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse2001.fromJson(value));
    }
    return map;
  }
}
