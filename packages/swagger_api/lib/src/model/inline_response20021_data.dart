part of '../api.dart';

class InlineResponse20021Data {
  User userInfo = null;

  String authKey = null;

  InlineResponse20021Data();

  @override
  String toString() {
    return 'InlineResponse20021Data[userInfo=$userInfo, authKey=$authKey, ]';
  }

  InlineResponse20021Data.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userInfo = new User.fromJson(json['userInfo']);
    authKey = json['authKey'];
  }

  Map<String, dynamic> toJson() {
    return {'userInfo': userInfo, 'authKey': authKey};
  }

  static List<InlineResponse20021Data> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse20021Data>()
        : json
            .map((value) => new InlineResponse20021Data.fromJson(value))
            .toList();
  }

  static Map<String, InlineResponse20021Data> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse20021Data>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse20021Data.fromJson(value));
    }
    return map;
  }
}
