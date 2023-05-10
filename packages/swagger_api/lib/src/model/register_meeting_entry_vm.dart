part of '../api.dart';

class RegisterMeetingEntryVm {
  /* The Id of the user that entered the meeting */
  String userId = null;

/* The date and time that the user entered the meeting */
  String enteredOn = null;

  RegisterMeetingEntryVm();

  @override
  String toString() {
    return 'RegisterMeetingEntryVm[userId=$userId, enteredOn=$enteredOn, ]';
  }

  RegisterMeetingEntryVm.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userId = json['userId'];
    enteredOn = json['enteredOn'];
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'enteredOn': enteredOn};
  }

  static List<RegisterMeetingEntryVm> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<RegisterMeetingEntryVm>()
        : json
            .map((value) => new RegisterMeetingEntryVm.fromJson(value))
            .toList();
  }

  static Map<String, RegisterMeetingEntryVm> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RegisterMeetingEntryVm>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new RegisterMeetingEntryVm.fromJson(value));
    }
    return map;
  }
}
