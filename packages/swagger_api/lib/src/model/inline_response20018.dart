part of '../api.dart';

class InlineResponse20018 {
  ApiResponse apiResponseMessage = null;

  ReportDetail data = null;

  InlineResponse20018();

  @override
  String toString() {
    return 'InlineResponse20018[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse20018.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = new ReportDetail.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse20018> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse20018>()
        : json.map((value) => new InlineResponse20018.fromJson(value)).toList();
  }

  static Map<String, InlineResponse20018> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse20018>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse20018.fromJson(value));
    }
    return map;
  }
}
