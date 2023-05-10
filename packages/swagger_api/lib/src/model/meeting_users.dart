part of '../api.dart';

class MeetingUsers {
  String userId = null;

  String userName = null;

  MeetingUsers();

  @override
  String toString() {
    return 'MeetingUsers[userId=$userId, userName=$userName, ]';
  }

  MeetingUsers.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userId = json['userId'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'userName': userName};
  }

  static List<MeetingUsers> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MeetingUsers>()
        : json.map((value) => new MeetingUsers.fromJson(value)).toList();
  }

  static Map<String, MeetingUsers> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MeetingUsers>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MeetingUsers.fromJson(value));
    }
    return map;
  }
}
