part of '../api.dart';

class InlineResponse20026 {
  ApiResponse apiResponseMessage = null;

  List<Meeting> data = [];

  InlineResponse20026();

  @override
  String toString() {
    return 'InlineResponse20026[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse20026.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = Meeting.listFromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse20026> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse20026>()
        : json.map((value) => new InlineResponse20026.fromJson(value)).toList();
  }

  static Map<String, InlineResponse20026> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse20026>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse20026.fromJson(value));
    }
    return map;
  }
}
