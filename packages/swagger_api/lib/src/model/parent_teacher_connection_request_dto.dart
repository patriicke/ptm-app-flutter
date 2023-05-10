part of '../api.dart';

class ParentTeacherConnectionRequestDto {
  String id = null;

  String parentUserId = null;

  String parentUserName = null;

  String parentUserDescription = null;

  ParentTeacherConnectionRequestDto();

  @override
  String toString() {
    return 'ParentTeacherConnectionRequestDto[id=$id, parentUserId=$parentUserId, parentUserName=$parentUserName, parentUserDescription=$parentUserDescription, ]';
  }

  ParentTeacherConnectionRequestDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    parentUserId = json['parentUserId'];
    parentUserName = json['parentUserName'];
    parentUserDescription = json['parentUserDescription'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parentUserId': parentUserId,
      'parentUserName': parentUserName,
      'parentUserDescription': parentUserDescription
    };
  }

  static List<ParentTeacherConnectionRequestDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<ParentTeacherConnectionRequestDto>()
        : json
            .map((value) =>
                new ParentTeacherConnectionRequestDto.fromJson(value))
            .toList();
  }

  static Map<String, ParentTeacherConnectionRequestDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ParentTeacherConnectionRequestDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ParentTeacherConnectionRequestDto.fromJson(value));
    }
    return map;
  }
}
