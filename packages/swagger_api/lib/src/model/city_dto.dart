part of '../api.dart';

class CityDto {
  String cityId = null;

  String cityName = null;

  String cityStatus = null;

  CityDto();

  @override
  String toString() {
    return 'CityDto[cityId=$cityId, cityName=$cityName, cityStatus=$cityStatus, ]';
  }

  CityDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    cityId = json['cityId'];
    cityName = json['cityName'];
    cityStatus = json['cityStatus'];
  }

  Map<String, dynamic> toJson() {
    return {'cityId': cityId, 'cityName': cityName, 'cityStatus': cityStatus};
  }

  static List<CityDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CityDto>()
        : json.map((value) => new CityDto.fromJson(value)).toList();
  }

  static Map<String, CityDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CityDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CityDto.fromJson(value));
    }
    return map;
  }
}
