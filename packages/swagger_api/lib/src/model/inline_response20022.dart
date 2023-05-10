part of '../api.dart';

class InlineResponse20022 {
  ApiResponse apiResponseMessage = null;

  InlineResponse20022Data data = null;

  InlineResponse20022();

  @override
  String toString() {
    return 'InlineResponse20022[apiResponseMessage=$apiResponseMessage, data=$data, ]';
  }

  InlineResponse20022.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    apiResponseMessage = new ApiResponse.fromJson(json['apiResponseMessage']);
    data = new InlineResponse20022Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    return {'apiResponseMessage': apiResponseMessage, 'data': data};
  }

  static List<InlineResponse20022> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse20022>()
        : json.map((value) => new InlineResponse20022.fromJson(value)).toList();
  }

  static Map<String, InlineResponse20022> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse20022>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse20022.fromJson(value));
    }
    return map;
  }
}
