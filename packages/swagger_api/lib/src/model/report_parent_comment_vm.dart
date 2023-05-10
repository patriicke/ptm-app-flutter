part of '../api.dart';

class ReportParentCommentVm {
  String parentUserId = null;

  String comment = null;

  int rating = null;
  //enum ratingEnum {  };
  ReportParentCommentVm();

  @override
  String toString() {
    return 'ReportParentCommentVm[parentUserId=$parentUserId, comment=$comment, rating=$rating, ]';
  }

  ReportParentCommentVm.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    parentUserId = json['parentUserId'];
    comment = json['comment'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    return {'parentUserId': parentUserId, 'comment': comment, 'rating': rating};
  }

  static List<ReportParentCommentVm> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ReportParentCommentVm>()
        : json
            .map((value) => new ReportParentCommentVm.fromJson(value))
            .toList();
  }

  static Map<String, ReportParentCommentVm> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ReportParentCommentVm>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ReportParentCommentVm.fromJson(value));
    }
    return map;
  }
}
