part of '../api.dart';

class UpdateMeetingStatusVm {
  /* The Id of the user for which the meeting status will be updated */
  String userId = null;

/* The new meeting status that will be set for the user */
  String newStatus = null;

  UpdateMeetingStatusVm();

  @override
  String toString() {
    return 'UpdateMeetingStatusVm[userId=$userId, newStatus=$newStatus, ]';
  }

  UpdateMeetingStatusVm.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userId = json['userId'];
    newStatus = json['newStatus'];
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'newStatus': newStatus};
  }

  static List<UpdateMeetingStatusVm> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UpdateMeetingStatusVm>()
        : json
            .map((value) => new UpdateMeetingStatusVm.fromJson(value))
            .toList();
  }

  static Map<String, UpdateMeetingStatusVm> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateMeetingStatusVm>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UpdateMeetingStatusVm.fromJson(value));
    }
    return map;
  }
}
