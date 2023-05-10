part of '../api.dart';

class CreateMeetingVm {
  String title = null;

  String meetingStartsOn = null;

  String meetingEndsOn = null;

  List<CreateMeetingVmUsers> users = [];

  CreateMeetingVm();

  @override
  String toString() {
    return 'CreateMeetingVm[title=$title, meetingStartsOn=$meetingStartsOn, meetingEndsOn=$meetingEndsOn, users=$users, ]';
  }

  CreateMeetingVm.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    title = json['title'];
    meetingStartsOn = json['meetingStartsOn'];
    meetingEndsOn = json['meetingEndsOn'];
    users = CreateMeetingVmUsers.listFromJson(json['users']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'meetingStartsOn': meetingStartsOn,
      'meetingEndsOn': meetingEndsOn,
      'users': users
    };
  }

  static List<CreateMeetingVm> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CreateMeetingVm>()
        : json.map((value) => new CreateMeetingVm.fromJson(value)).toList();
  }

  static Map<String, CreateMeetingVm> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateMeetingVm>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CreateMeetingVm.fromJson(value));
    }
    return map;
  }
}
