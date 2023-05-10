part of '../api.dart';

class UserSignupVm {
  String username = null;

  String email = null;

  String password = null;

  String phone = null;

  String about = null;

/* Parent(0) or teacher(1) */
  int userType = null;
  //enum userTypeEnum {  0,  1,  };
  UserSignupVm();

  @override
  String toString() {
    return 'UserSignupVm[username=$username, email=$email, password=$password, phone=$phone, about=$about, userType=$userType, ]';
  }

  UserSignupVm.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    username = json['username'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    about = json['about'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'phone': phone,
      'about': about,
      'userType': userType
    };
  }

  static List<UserSignupVm> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UserSignupVm>()
        : json.map((value) => new UserSignupVm.fromJson(value)).toList();
  }

  static Map<String, UserSignupVm> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UserSignupVm>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UserSignupVm.fromJson(value));
    }
    return map;
  }
}
