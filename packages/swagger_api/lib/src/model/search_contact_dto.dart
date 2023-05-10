part of '../api.dart';

class SearchContactDto {
  String contactUserId = null;

  String contactUserName = null;

/* Parents(0), teachers(1) */
  int contactUserType = null;

  SearchContactDto();

  @override
  String toString() {
    return 'SearchContactDto[contactUserId=$contactUserId, contactUserName=$contactUserName, contactUserType=$contactUserType, ]';
  }

  SearchContactDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    contactUserId = json['contactUserId'];
    contactUserName = json['contactUserName'];
    contactUserType = json['contactUserType'];
  }

  Map<String, dynamic> toJson() {
    return {
      'contactUserId': contactUserId,
      'contactUserName': contactUserName,
      'contactUserType': contactUserType
    };
  }

  static List<SearchContactDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<SearchContactDto>()
        : json.map((value) => new SearchContactDto.fromJson(value)).toList();
  }

  static Map<String, SearchContactDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SearchContactDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new SearchContactDto.fromJson(value));
    }
    return map;
  }
}
