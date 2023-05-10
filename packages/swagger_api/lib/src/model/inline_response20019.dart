part of '../api.dart';

class InlineResponse20019 {
  ApiResponse apiResponseMessage = null;

  List<ReportListItemDto> data = [];

  InlineResponse20019();

  @override
  String toString() {
    return 'InlineResponse20019[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse20019.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = ReportListItemDto.listFromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse20019> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse20019>()
        : json.map((value) => new InlineResponse20019.fromJson(value)).toList();
  }

  static Map<String, InlineResponse20019> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse20019>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse20019.fromJson(value));
    }
    return map;
  }
}
