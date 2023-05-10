part of '../api.dart';

class InlineResponse20011 {
  ApiResponse apiResponseMessage = null;

  ChatMessage data = null;

  InlineResponse20011();

  @override
  String toString() {
    return 'InlineResponse20011[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse20011.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = new ChatMessage.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse20011> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse20011>()
        : json.map((value) => new InlineResponse20011.fromJson(value)).toList();
  }

  static Map<String, InlineResponse20011> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse20011>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse20011.fromJson(value));
    }
    return map;
  }
}
