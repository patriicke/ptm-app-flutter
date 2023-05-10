part of '../api.dart';

class InlineResponse20022Data {
  String userId = null;

  String authKey = null;

  InlineResponse20022Data();

  @override
  String toString() {
    return 'InlineResponse20022Data[userId=$userId, authKey=$authKey, ]';
  }

  InlineResponse20022Data.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userId = json['userId'];
    authKey = json['authKey'];
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'authKey': authKey};
  }

  static List<InlineResponse20022Data> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse20022Data>()
        : json
            .map((value) => new InlineResponse20022Data.fromJson(value))
            .toList();
  }

  static Map<String, InlineResponse20022Data> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse20022Data>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse20022Data.fromJson(value));
    }
    return map;
  }
}
