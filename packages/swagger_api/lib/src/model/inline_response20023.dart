part of '../api.dart';

class InlineResponse20023 {
  ApiResponse apiResponseMessage = null;

  List<UserSearchResultDto> data = [];

  InlineResponse20023();

  @override
  String toString() {
    return 'InlineResponse20023[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse20023.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = UserSearchResultDto.listFromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse20023> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse20023>()
        : json.map((value) => new InlineResponse20023.fromJson(value)).toList();
  }

  static Map<String, InlineResponse20023> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse20023>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse20023.fromJson(value));
    }
    return map;
  }
}
