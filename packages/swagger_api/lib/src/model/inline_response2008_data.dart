part of '../api.dart';

class InlineResponse2008Data {
  ContactUserDto parent = null;

  InlineResponse2008Data();

  @override
  String toString() {
    return 'InlineResponse2008Data[parent=$parent, ]';
  }

  InlineResponse2008Data.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    parent = new ContactUserDto.fromJson(json['parent']);
  }

  Map<String, dynamic> toJson() {
    return {'parent': parent};
  }

  static List<InlineResponse2008Data> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InlineResponse2008Data>()
        : json
            .map((value) => new InlineResponse2008Data.fromJson(value))
            .toList();
  }

  static Map<String, InlineResponse2008Data> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InlineResponse2008Data>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InlineResponse2008Data.fromJson(value));
    }
    return map;
  }
}
