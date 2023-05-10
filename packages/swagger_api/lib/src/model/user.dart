part of '../api.dart';

class User {
  String id = null;

  String username = null;

  String about = null;

  String email = null;

  String phone = null;

/* The current account status of the user. */
  String status = null;
  //enum statusEnum {  parentVerifying,  parentSignedUp,  parentChildrenSubmitted,  parentTeachersConnected,  parentProfileCompleted,  teacherVerifying,  teacherSignedUp,  teacherInfoSubmitted,  teacherProfileCompleted,  blocked,  };
/* Parent(0) or teacher(1) */
  int userType = null;
  //enum userTypeEnum {  0,  1,  };

  String authKey = null;

  String photoImageLink = null;

  int meetingsCount = null;

  int reportsCount = null;

/* Number of teachers linked to this parent. Only viable for parent users. */
  int teachersCount = null;

/* Number of parents linked to this teacher. Only viable for teacher users. */
  int parentsCount = null;

  User();

  @override
  String toString() {
    return 'User[id=$id, username=$username, about=$about, email=$email, phone=$phone, photoImageLink=$photoImageLink, status=$status, userType=$userType, authKey=$authKey, meetingsCount=$meetingsCount, reportsCount=$reportsCount, teachersCount=$teachersCount, parentsCount=$parentsCount, ]';
  }

  User.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    username = json['username'];
    about = json['about'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
    userType = json['userType'];
    authKey = json['authKey'];
    photoImageLink = json['photoImageLink'];
    meetingsCount = json['meetingsCount'];
    reportsCount = json['reportsCount'];
    teachersCount = json['teachersCount'];
    parentsCount = json['parentsCount'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'about': about,
      'email': email,
      'phone': phone,
      'status': status,
      'userType': userType,
      'authKey': authKey,
      'photoImageLink': photoImageLink,
      'meetingsCount': meetingsCount,
      'reportsCount': reportsCount,
      'teachersCount': teachersCount,
      'parentsCount': parentsCount
    };
  }

  static List<User> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<User>()
        : json.map((value) => new User.fromJson(value)).toList();
  }

  static Map<String, User> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, User>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new User.fromJson(value));
    }
    return map;
  }
}
