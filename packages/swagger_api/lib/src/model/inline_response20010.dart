part of '../api.dart';

class InlineResponse20010 {
  ApiResponse apiResponseMessage = null;

  InlineResponse20010Data data = null;

  InlineResponse20010();

  @override
  String toString() {
    return 'InlineResponse20010[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse20010.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = new InlineResponse20010Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse20010> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse20010>()
        : json.map((value) => new InlineResponse20010.fromJson(value)).toList();
  }

  static Map<String, InlineResponse20010> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse20010>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse20010.fromJson(value));
    }
    return map;
  }
}
