part of '../api.dart';

class ChatContactDto {
  String contactUserId = null;

  String contactUserName = null;

/* Parents(0), teachers(1) */
  int contactUserType = null;

  String lastMessageBody = null;

  String lastMessageOn = null;

  int unreadMessagesCount = null;

  ChatContactDto();

  @override
  String toString() {
    return 'ChatContactDto[contactUserId=$contactUserId, contactUserName=$contactUserName, contactUserType=$contactUserType, lastMessageBody=$lastMessageBody, lastMessageOn=$lastMessageOn, unreadMessagesCount=$unreadMessagesCount, ]';
  }

  ChatContactDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    contactUserId = json['contactUserId'];
    contactUserName = json['contactUserName'];
    contactUserType = json['contactUserType'];
    lastMessageBody = json['lastMessageBody'];
    lastMessageOn = json['lastMessageOn'];
    unreadMessagesCount = json['unreadMessagesCount'];
  }

  Map<String, dynamic> toJson() {
    return {
      'contactUserId': contactUserId,
      'contactUserName': contactUserName,
      'contactUserType': contactUserType,
      'lastMessageBody': lastMessageBody,
      'lastMessageOn': lastMessageOn,
      'unreadMessagesCount': unreadMessagesCount
    };
  }

  static List<ChatContactDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ChatContactDto>()
        : json.map((value) => new ChatContactDto.fromJson(value)).toList();
  }

  static Map<String, ChatContactDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ChatContactDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ChatContactDto.fromJson(value));
    }
    return map;
  }
}
