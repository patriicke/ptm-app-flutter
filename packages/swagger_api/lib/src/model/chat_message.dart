part of '../api.dart';

class ChatMessage {
  String byUserId = null;

  String toUserId = null;

  String body = null;

  bool read = null;

  String messageOn = null;

  ChatMessage();

  @override
  String toString() {
    return 'ChatMessage[byUserId=$byUserId, toUserId=$toUserId, body=$body, read=$read, messageOn=$messageOn, ]';
  }

  ChatMessage.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    byUserId = json['byUserId'];
    toUserId = json['toUserId'];
    body = json['body'];
    read = json['read'];
    messageOn = json['messageOn'];
  }

  Map<String, dynamic> toJson() {
    return {
      'byUserId': byUserId,
      'toUserId': toUserId,
      'body': body,
      'read': read,
      'messageOn': messageOn
    };
  }

  static List<ChatMessage> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ChatMessage>()
        : json.map((value) => new ChatMessage.fromJson(value)).toList();
  }

  static Map<String, ChatMessage> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ChatMessage>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ChatMessage.fromJson(value));
    }
    return map;
  }
}
