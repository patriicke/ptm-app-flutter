part of '../api.dart';

class ContactSearchResult {
  String userId = null;

  String userName = null;

/* Parent(0), Teacher(1) */
  int userType = null;

  ContactSearchResult();

  @override
  String toString() {
    return 'ContactSearchResult[userId=$userId, userName=$userName, userType=$userType, ]';
  }

  ContactSearchResult.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userId = json['userId'];
    userName = json['userName'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'userName': userName, 'userType': userType};
  }

  static List<ContactSearchResult> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ContactSearchResult>()
        : json.map((value) => new ContactSearchResult.fromJson(value)).toList();
  }

  static Map<String, ContactSearchResult> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ContactSearchResult>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ContactSearchResult.fromJson(value));
    }
    return map;
  }
}
