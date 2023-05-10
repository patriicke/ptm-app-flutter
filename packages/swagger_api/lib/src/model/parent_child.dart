part of '../api.dart';

class ParentChild {
  String name = null;

  String grade = null;
  //enum gradeEnum {  Grade1,  Grade2,  Grade3,  Grade4,  Grade5,  Grade6,  Grade7,  Grade8,  Grade9,  Grade10,  Grade11,  Grade12,  };
  ParentChild();

  @override
  String toString() {
    return 'ParentChild[name=$name, grade=$grade, ]';
  }

  ParentChild.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    grade = json['grade'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'grade': grade};
  }

  static List<ParentChild> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ParentChild>()
        : json.map((value) => new ParentChild.fromJson(value)).toList();
  }

  static Map<String, ParentChild> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ParentChild>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ParentChild.fromJson(value));
    }
    return map;
  }
}
