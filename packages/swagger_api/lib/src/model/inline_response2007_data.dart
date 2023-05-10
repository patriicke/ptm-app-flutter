part of '../api.dart';

class InlineResponse2007Data {
  ContactUserDto teacher = null;

  List<TeacherAvailability> weeklyAvailability = [];

  InlineResponse2007Data();

  @override
  String toString() {
    return 'InlineResponse2007Data[teacher=$teacher, weeklyAvailability=$weeklyAvailability, ]';
  }

  InlineResponse2007Data.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    teacher = new ContactUserDto.fromJson(json['teacher']);
    weeklyAvailability =
        TeacherAvailability.listFromJson(json['weeklyAvailability']);
  }

  Map<String, dynamic> toJson() {
    return {'teacher': teacher, 'weeklyAvailability': weeklyAvailability};
  }

  static List<InlineResponse2007Data> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse2007Data>()
        : json
            .map((value) => new InlineResponse2007Data.fromJson(value))
            .toList();
  }

  static Map<String, InlineResponse2007Data> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse2007Data>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse2007Data.fromJson(value));
    }
    return map;
  }
}
