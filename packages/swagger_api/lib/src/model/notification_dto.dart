part of '../api.dart';

class NotificationDto {
  String notificationId = null;

  String byUserId = null;

  String byUserName = null;

/* The exact date and time the notification event took place */
  String notifiedOn = null;

/* What was the notification about? */
  String message = null;

  bool seen = null;

  NotificationDto();

  @override
  String toString() {
    return 'NotificationDto[notificationId=$notificationId, byUserId=$byUserId, byUserName=$byUserName, notifiedOn=$notifiedOn, message=$message, seen=$seen, ]';
  }

  NotificationDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    notificationId = json['notificationId'];
    byUserId = json['byUserId'];
    byUserName = json['byUserName'];
    notifiedOn = json['notifiedOn'];
    message = json['message'];
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationId': notificationId,
      'byUserId': byUserId,
      'byUserName': byUserName,
      'notifiedOn': notifiedOn,
      'message': message,
      'seen': seen
    };
  }

  static List<NotificationDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<NotificationDto>()
        : json.map((value) => new NotificationDto.fromJson(value)).toList();
  }

  static Map<String, NotificationDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, NotificationDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new NotificationDto.fromJson(value));
    }
    return map;
  }
}
