part of '../api.dart';

class InlineResponse20013 {
  ApiResponse apiResponseMessage = null;

  List<ChatContactDto> data = [];

  InlineResponse20013();

  @override
  String toString() {
    return 'InlineResponse20013[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse20013.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = ChatContactDto.listFromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse20013> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse20013>()
        : json.map((value) => new InlineResponse20013.fromJson(value)).toList();
  }

  static Map<String, InlineResponse20013> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse20013>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse20013.fromJson(value));
    }
    return map;
  }
}
