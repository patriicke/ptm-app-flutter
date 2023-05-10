part of '../api.dart';

class InlineResponse20028 {
  ApiResponse apiResponseMessage = null;

/* updated meeting object */
  Meeting data = null;

  InlineResponse20028();

  @override
  String toString() {
    return 'InlineResponse20028[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse20028.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = new Meeting.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse20028> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse20028>()
        : json.map((value) => new InlineResponse20028.fromJson(value)).toList();
  }

  static Map<String, InlineResponse20028> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse20028>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse20028.fromJson(value));
    }
    return map;
  }
}
