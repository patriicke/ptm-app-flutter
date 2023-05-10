part of '../api.dart';

class MeetingRequestDto {
  String id = null;

  String requesterUserId = null;

  String requesterUserName = null;

  String requesterUserDescription = null;

/* Id of the meeting that this notification is related to. */
  String meetingId = null;

  MeetingRequestDto();

  @override
  String toString() {
    return 'MeetingRequestDto[id=$id, requesterUserId=$requesterUserId, requesterUserName=$requesterUserName, requesterUserDescription=$requesterUserDescription, meetingId=$meetingId, ]';
  }

  MeetingRequestDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    requesterUserId = json['requesterUserId'];
    requesterUserName = json['requesterUserName'];
    requesterUserDescription = json['requesterUserDescription'];
    meetingId = json['meetingId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'requesterUserId': requesterUserId,
      'requesterUserName': requesterUserName,
      'requesterUserDescription': requesterUserDescription,
      'meetingId': meetingId
    };
  }

  static List<MeetingRequestDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MeetingRequestDto>()
        : json.map((value) => new MeetingRequestDto.fromJson(value)).toList();
  }

  static Map<String, MeetingRequestDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MeetingRequestDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MeetingRequestDto.fromJson(value));
    }
    return map;
  }
}
