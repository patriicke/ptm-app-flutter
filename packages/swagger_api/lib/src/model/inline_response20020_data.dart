part of '../api.dart';

class InlineResponse20020Data {
  User user = null;

  String signupEventId = null;

  InlineResponse20020Data();

  @override
  String toString() {
    return 'InlineResponse20020Data[user=$user, signupEventId=$signupEventId, ]';
  }

  InlineResponse20020Data.fromJson(Map<String, dynamic> json) {
    print("json--${json}");
    if (json == null) return;
    user = new User.fromJson(json['user']);
    signupEventId = json['signupEventId'];
  }

  Map<String, dynamic> toJson() {
    return {'user': user, 'signupEventId': signupEventId};
  }

  static List<InlineResponse20020Data> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse20020Data>()
        : json
            .map((value) => new InlineResponse20020Data.fromJson(value))
            .toList();
  }

  static Map<String, InlineResponse20020Data> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse20020Data>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse20020Data.fromJson(value));
    }
    return map;
  }
}
