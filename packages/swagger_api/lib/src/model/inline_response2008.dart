part of '../api.dart';

class InlineResponse2008 {
  ApiResponse apiResponseMessage = null;

  InlineResponse2008Data data = null;

  InlineResponse2008();

  @override
  String toString() {
    return 'InlineResponse2008[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse2008.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = new InlineResponse2008Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse2008> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse2008>()
        : json.map((value) => new InlineResponse2008.fromJson(value)).toList();
  }

  static Map<String, InlineResponse2008> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse2008>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse2008.fromJson(value));
    }
    return map;
  }
}
