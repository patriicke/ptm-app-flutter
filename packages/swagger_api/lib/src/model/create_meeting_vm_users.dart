part of '../api.dart';

class CreateMeetingVmUsers {
  String userId = null;

/* Parents(0), Teachers(1) */
  int userType = null;

  CreateMeetingVmUsers();

  @override
  String toString() {
    return 'CreateMeetingVmUsers[userId=$userId, userType=$userType, ]';
  }

  CreateMeetingVmUsers.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userId = json['userId'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'userType': userType};
  }

  static List<CreateMeetingVmUsers> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CreateMeetingVmUsers>()
        : json
            .map((value) => new CreateMeetingVmUsers.fromJson(value))
            .toList();
  }

  static Map<String, CreateMeetingVmUsers> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateMeetingVmUsers>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CreateMeetingVmUsers.fromJson(value));
    }
    return map;
  }
}
