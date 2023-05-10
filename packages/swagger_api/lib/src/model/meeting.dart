part of '../api.dart';

class Meeting {
  String id = null;

  String title = null;

  String meetingStartsOn = null;

  String meetingEndsOn = null;

/* The date and time that the user last attended this meeting. Must be null or empty if not attended before */
  String lastEnteredOn = null;

  List<MeetingUsers> users = [];

  String meetingRoom = null;

  String meetingSubject = null;

/* Determines whether the user is attending the meeting or not */
  String meetingStatus = null;
  //enum meetingStatusEnum {  requested,  going,  notGoing,  };
  Meeting();

  @override
  String toString() {
    return 'Meeting[id=$id, title=$title, meetingStartsOn=$meetingStartsOn, meetingEndsOn=$meetingEndsOn, lastEnteredOn=$lastEnteredOn, users=$users, meetingRoom=$meetingRoom, meetingSubject=$meetingSubject, meetingStatus=$meetingStatus, ]';
  }

  Meeting.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    title = json['title'];
    meetingStartsOn = json['meetingStartsOn'];
    meetingEndsOn = json['meetingEndsOn'];
    lastEnteredOn = json['lastEnteredOn'];
    users = MeetingUsers.listFromJson(json['users']);
    meetingRoom = json['meetingRoom'];
    meetingSubject = json['meetingSubject'];
    meetingStatus = json['meetingStatus'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'meetingStartsOn': meetingStartsOn,
      'meetingEndsOn': meetingEndsOn,
      'lastEnteredOn': lastEnteredOn,
      'users': users,
      'meetingRoom': meetingRoom,
      'meetingSubject': meetingSubject,
      'meetingStatus': meetingStatus
    };
  }

  static List<Meeting> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<Meeting>()
        : json.map((value) => new Meeting.fromJson(value)).toList();
  }

  static Map<String, Meeting> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Meeting>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new Meeting.fromJson(value));
    }
    return map;
  }
}
