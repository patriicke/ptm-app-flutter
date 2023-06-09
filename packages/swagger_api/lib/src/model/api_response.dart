part of '../api.dart';

class ApiResponse {
  int code = null;

  String message = null;

  ApiResponse();

  @override
  String toString() {
    return 'ApiResponse[code=$code, message=$message, ]';
  }

  ApiResponse.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'message': message};
  }

  static List<ApiResponse> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ApiResponse>()
        : json.map((value) => new ApiResponse.fromJson(value)).toList();
  }

  static Map<String, ApiResponse> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ApiResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ApiResponse.fromJson(value));
    }
    return map;
  }
}
