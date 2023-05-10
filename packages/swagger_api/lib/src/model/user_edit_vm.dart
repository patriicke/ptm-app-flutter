part of '../api.dart';

class UserEditVm {
  String username = null;

  String email = null;

  String password = null;

  String phone = null;

  UserEditVm();

  @override
  String toString() {
    return 'UserEditVm[username=$username, email=$email, password=$password, phone=$phone, ]';
  }

  UserEditVm.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    username = json['username'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'phone': phone
    };
  }

  static List<UserEditVm> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UserEditVm>()
        : json.map((value) => new UserEditVm.fromJson(value)).toList();
  }

  static Map<String, UserEditVm> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UserEditVm>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UserEditVm.fromJson(value));
    }
    return map;
  }
}
