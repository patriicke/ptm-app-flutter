part of '../api.dart';

class InlineResponse2007 {
  ApiResponse apiResponseMessage = null;

  InlineResponse2007Data data = null;

  InlineResponse2007();

  @override
  String toString() {
    return 'InlineResponse2007[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse2007.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = new InlineResponse2007Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse2007> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse2007>()
        : json.map((value) => new InlineResponse2007.fromJson(value)).toList();
  }

  static Map<String, InlineResponse2007> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse2007>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse2007.fromJson(value));
    }
    return map;
  }
}
