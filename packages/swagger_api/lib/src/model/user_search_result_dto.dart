part of '../api.dart';

class UserSearchResultDto {
  String id = null;

  String name = null;

/* Parent(0), Teacher(1) */
  int userType = null;

  UserSearchResultDto();

  @override
  String toString() {
    return 'UserSearchResultDto[id=$id, name=$name, userType=$userType, ]';
  }

  UserSearchResultDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'userType': userType};
  }

  static List<UserSearchResultDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UserSearchResultDto>()
        : json.map((value) => new UserSearchResultDto.fromJson(value)).toList();
  }

  static Map<String, UserSearchResultDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UserSearchResultDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UserSearchResultDto.fromJson(value));
    }
    return map;
  }
}
