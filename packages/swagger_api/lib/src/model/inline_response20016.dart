part of '../api.dart';

class InlineResponse20016 {
  ApiResponse apiResponseMessage = null;

  List<TeacherAvailability> data = [];

  InlineResponse20016();

  @override
  String toString() {
    return 'InlineResponse20016[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse20016.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = TeacherAvailability.listFromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse20016> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse20016>()
        : json.map((value) => new InlineResponse20016.fromJson(value)).toList();
  }

  static Map<String, InlineResponse20016> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse20016>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse20016.fromJson(value));
    }
    return map;
  }
}
