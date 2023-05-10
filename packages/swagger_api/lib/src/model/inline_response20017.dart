part of '../api.dart';

class InlineResponse20017 {
  ApiResponse apiResponseMessage = null;

  List<StudentSearchResult> data = [];

  InlineResponse20017();

  @override
  String toString() {
    return 'InlineResponse20017[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse20017.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = StudentSearchResult.listFromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse20017> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse20017>()
        : json.map((value) => new InlineResponse20017.fromJson(value)).toList();
  }

  static Map<String, InlineResponse20017> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse20017>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse20017.fromJson(value));
    }
    return map;
  }
}
