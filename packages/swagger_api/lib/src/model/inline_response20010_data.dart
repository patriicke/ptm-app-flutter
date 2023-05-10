part of '../api.dart';

class InlineResponse20010Data {
  String contactUserId = null;

  String contactUserName = null;

  String contactUserDescription = null;

/* Parents(0), teachers(1) */
  int contactUserType = null;

  List<ChatMessage> messages = [];

  InlineResponse20010Data();

  @override
  String toString() {
    return 'InlineResponse20010Data[contactUserId=$contactUserId, contactUserName=$contactUserName, contactUserDescription=$contactUserDescription, contactUserType=$contactUserType, messages=$messages, ]';
  }

  InlineResponse20010Data.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    contactUserId = json['contactUserId'];
    contactUserName = json['contactUserName'];
    contactUserDescription = json['contactUserDescription'];
    contactUserType = json['contactUserType'];
    messages = ChatMessage.listFromJson(json['messages']);
  }

  Map<String, dynamic> toJson() {
    return {
      'contactUserId': contactUserId,
      'contactUserName': contactUserName,
      'contactUserDescription': contactUserDescription,
      'contactUserType': contactUserType,
      'messages': messages
    };
  }

  static List<InlineResponse20010Data> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse20010Data>()
        : json
            .map((value) => new InlineResponse20010Data.fromJson(value))
            .toList();
  }

  static Map<String, InlineResponse20010Data> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse20010Data>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse20010Data.fromJson(value));
    }
    return map;
  }
}
