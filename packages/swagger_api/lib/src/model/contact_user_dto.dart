part of '../api.dart';

class ContactUserDto {
  String id = null;

  String username = null;

/* Parent(0) or teacher(1) */
  int userType = null;
  //enum userTypeEnum {  0,  1,  };

  int meetingsCount = null;

  int reportsCount = null;

  ContactUserDto();

  @override
  String toString() {
    return 'ContactUserDto[id=$id, username=$username, userType=$userType, meetingsCount=$meetingsCount, reportsCount=$reportsCount, ]';
  }

  ContactUserDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    username = json['username'];
    userType = json['userType'];
    meetingsCount = json['meetingsCount'];
    reportsCount = json['reportsCount'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'userType': userType,
      'meetingsCount': meetingsCount,
      'reportsCount': reportsCount
    };
  }

  static List<ContactUserDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ContactUserDto>()
        : json.map((value) => new ContactUserDto.fromJson(value)).toList();
  }

  static Map<String, ContactUserDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ContactUserDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ContactUserDto.fromJson(value));
    }
    return map;
  }
}
