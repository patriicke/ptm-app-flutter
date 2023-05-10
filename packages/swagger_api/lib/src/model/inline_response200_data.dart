part of '../api.dart';

class InlineResponse200Data {
  int signupEventId = null;

  InlineResponse200Data();

  @override
  String toString() {
    return 'InlineResponse200Data[signupEventId=$signupEventId, ]';
  }

  InlineResponse200Data.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    signupEventId = json['signupEventId'];
  }

  Map<String, dynamic> toJson() {
    return {'signupEventId': signupEventId};
  }

  static List<InlineResponse200Data> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse200Data>()
        : json
            .map((value) => new InlineResponse200Data.fromJson(value))
            .toList();
  }

  static Map<String, InlineResponse200Data> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse200Data>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse200Data.fromJson(value));
    }
    return map;
  }
}
