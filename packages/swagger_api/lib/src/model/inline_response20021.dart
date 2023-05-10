part of '../api.dart';

class InlineResponse20021 {
  ApiResponse apiResponseMessage = null;

  InlineResponse20021Data data = null;

  InlineResponse20021();

  @override
  String toString() {
    return 'InlineResponse20021[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse20021.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = new InlineResponse20021Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse20021> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse20021>()
        : json.map((value) => new InlineResponse20021.fromJson(value)).toList();
  }

  static Map<String, InlineResponse20021> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse20021>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse20021.fromJson(value));
    }
    return map;
  }
}
