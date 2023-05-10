part of '../api.dart';

class InlineResponse200 {
  ApiResponse apiResponseMessage = null;

  InlineResponse200Data data = null;

  InlineResponse200();

  @override
  String toString() {
    return 'InlineResponse200[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse200.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = new InlineResponse200Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse200> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse200>()
        : json.map((value) => new InlineResponse200.fromJson(value)).toList();
  }

  static Map<String, InlineResponse200> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse200>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse200.fromJson(value));
    }
    return map;
  }
}
