part of '../api.dart';

class ProfileCompletionVm {
  /* The path of the pre-uploaded profile image file in the storage bucket */
  String profileImagePath = null;

  String gender = null;
  //enum genderEnum {  male,  female,  };

  String dateOfBirth = null;

  ProfileCompletionVm();

  @override
  String toString() {
    return 'ProfileCompletionVm[profileImagePath=$profileImagePath, gender=$gender, dateOfBirth=$dateOfBirth, ]';
  }

  ProfileCompletionVm.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    profileImagePath = json['profileImagePath'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    return {
      'profileImagePath': profileImagePath,
      'gender': gender,
      'dateOfBirth': dateOfBirth
    };
  }

  static List<ProfileCompletionVm> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ProfileCompletionVm>()
        : json.map((value) => new ProfileCompletionVm.fromJson(value)).toList();
  }

  static Map<String, ProfileCompletionVm> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ProfileCompletionVm>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ProfileCompletionVm.fromJson(value));
    }
    return map;
  }
}
