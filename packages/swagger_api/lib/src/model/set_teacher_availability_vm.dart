part of '../api.dart';

class SetTeacherAvailabilityVm {
  String availabilityDate = null;

  String availabilityStartTime = null;

  String availabilityEndTime = null;

  String availabilityType = null;
  //enum availabilityTypeEnum {  unavailable,  availableForMeetings,  };

  String whoCanSee = null;
  //enum whoCanSeeEnum {  justMe,  everyone,  };

  bool repeat = null;

  String repeatEvery = null;
  //enum repeatEveryEnum {  day,  week,  month,  year,  };

  String repeatEndDate = null;

  SetTeacherAvailabilityVm();

  @override
  String toString() {
    return 'SetTeacherAvailabilityVm[availabilityDate=$availabilityDate, availabilityStartTime=$availabilityStartTime, availabilityEndTime=$availabilityEndTime, availabilityType=$availabilityType, whoCanSee=$whoCanSee, repeat=$repeat, repeatEvery=$repeatEvery, repeatEndDate=$repeatEndDate, ]';
  }

  SetTeacherAvailabilityVm.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    availabilityDate = json['availabilityDate'];
    availabilityStartTime = json['availabilityStartTime'];
    availabilityEndTime = json['availabilityEndTime'];
    availabilityType = json['availabilityType'];
    whoCanSee = json['whoCanSee'];
    repeat = json['repeat'];
    repeatEvery = json['repeatEvery'];
    repeatEndDate = json['repeatEndDate'];
  }

  Map<String, dynamic> toJson() {
    return {
      'availabilityDate': availabilityDate,
      'availabilityStartTime': availabilityStartTime,
      'availabilityEndTime': availabilityEndTime,
      'availabilityType': availabilityType,
      'whoCanSee': whoCanSee,
      'repeat': repeat,
      'repeatEvery': repeatEvery,
      'repeatEndDate': repeatEndDate
    };
  }

  static List<SetTeacherAvailabilityVm> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<SetTeacherAvailabilityVm>()
        : json
            .map((value) => new SetTeacherAvailabilityVm.fromJson(value))
            .toList();
  }

  static Map<String, SetTeacherAvailabilityVm> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SetTeacherAvailabilityVm>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new SetTeacherAvailabilityVm.fromJson(value));
    }
    return map;
  }
}
