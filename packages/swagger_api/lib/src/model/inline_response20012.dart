part of '../api.dart';

class InlineResponse20012 {
  ApiResponse apiResponseMessage = null;

  List<SearchContactDto> data = [];

  InlineResponse20012();

  @override
  String toString() {
    return 'InlineResponse20012[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse20012.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = SearchContactDto.listFromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse20012> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse20012>()
        : json.map((value) => new InlineResponse20012.fromJson(value)).toList();
  }

  static Map<String, InlineResponse20012> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse20012>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse20012.fromJson(value));
    }
    return map;
  }
}
