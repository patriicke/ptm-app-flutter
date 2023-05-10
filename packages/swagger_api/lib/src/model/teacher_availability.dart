part of '../api.dart';

class TeacherAvailability {
  String availabilityDate = null;

  String availabilityStartTime = null;

  String availabilityEndTime = null;

  String availabilityType = null;
  //enum availabilityTypeEnum {  unavailable,  availableForMeetings,  };

  String whoCanSee = null;
  //enum whoCanSeeEnum {  justMe,  everyone,  };
  TeacherAvailability();

  @override
  String toString() {
    return 'TeacherAvailability[availabilityDate=$availabilityDate, availabilityStartTime=$availabilityStartTime, availabilityEndTime=$availabilityEndTime, availabilityType=$availabilityType, whoCanSee=$whoCanSee, ]';
  }

  TeacherAvailability.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    availabilityDate = json['availabilityDate'];
    availabilityStartTime = json['availabilityStartTime'];
    availabilityEndTime = json['availabilityEndTime'];
    availabilityType = json['availabilityType'];
    whoCanSee = json['whoCanSee'];
  }

  Map<String, dynamic> toJson() {
    return {
      'availabilityDate': availabilityDate,
      'availabilityStartTime': availabilityStartTime,
      'availabilityEndTime': availabilityEndTime,
      'availabilityType': availabilityType,
      'whoCanSee': whoCanSee
    };
  }

  static List<TeacherAvailability> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<TeacherAvailability>()
        : json.map((value) => new TeacherAvailability.fromJson(value)).toList();
  }

  static Map<String, TeacherAvailability> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, TeacherAvailability>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new TeacherAvailability.fromJson(value));
    }
    return map;
  }
}
