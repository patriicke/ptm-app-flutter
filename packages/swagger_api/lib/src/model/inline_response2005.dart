part of '../api.dart';

class InlineResponse2005 {
  ApiResponse apiResponseMessage = null;

  List<MeetingRequestDto> data = [];

  InlineResponse2005();

  @override
  String toString() {
    return 'InlineResponse2005[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse2005.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = MeetingRequestDto.listFromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse2005> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse2005>()
        : json.map((value) => new InlineResponse2005.fromJson(value)).toList();
  }

  static Map<String, InlineResponse2005> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse2005>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse2005.fromJson(value));
    }
    return map;
  }
}
