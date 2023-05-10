part of 'api.dart';

class QueryParam {
  String name;
  String value;

  QueryParam(this.name, this.value);
}

class ApiClient {
  String basePath;
  var client = new IOClient();

  Map<String, String> _defaultHeaderMap = {};
  Map<String, Authentication> _authentications = {};

  final _RegList = new RegExp(r'^List<(.*)>$');
  final _RegMap = new RegExp(r'^Map<String,(.*)>$');

  ApiClient({this.basePath: "https://parentteachermobile.com/service"}) {
    //Setup authentications (key: authentication name, value: authentication).
  }

  void addDefaultHeader(String key, String value) {
    _defaultHeaderMap[key] = value;
  }

  dynamic _deserialize(dynamic value, String targetType) {
    try {
      switch (targetType) {
        case 'String':
          return '$value';
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'bool':
          return value is bool ? value : '$value'.toLowerCase() == 'true';
        case 'double':
          return value is double ? value : double.parse('$value');
        case 'ApiResponse':
          return new ApiResponse.fromJson(value);
        case 'Body':
          return new Body.fromJson(value);
        case 'ChatContactDto':
          return new ChatContactDto.fromJson(value);
        case 'ChatMessage':
          return new ChatMessage.fromJson(value);
        case 'CityDto':
          return new CityDto.fromJson(value);
        case 'ContactSearchResult':
          return new ContactSearchResult.fromJson(value);
        case 'ContactUserDto':
          return new ContactUserDto.fromJson(value);
        case 'CreateEditReportVm':
          return new CreateEditReportVm.fromJson(value);
        case 'CreateMeetingVm':
          return new CreateMeetingVm.fromJson(value);
        case 'CreateMeetingVmUsers':
          return new CreateMeetingVmUsers.fromJson(value);
        case 'GradeDto':
          return new GradeDto.fromJson(value);
        case 'InlineResponse200':
          return new InlineResponse200.fromJson(value);
        case 'InlineResponse2001':
          return new InlineResponse2001.fromJson(value);
        case 'InlineResponse20010':
          return new InlineResponse20010.fromJson(value);
        case 'InlineResponse20010Data':
          return new InlineResponse20010Data.fromJson(value);
        case 'InlineResponse20011':
          return new InlineResponse20011.fromJson(value);
        case 'InlineResponse20012':
          return new InlineResponse20012.fromJson(value);
        case 'InlineResponse20013':
          return new InlineResponse20013.fromJson(value);
        case 'InlineResponse20014':
          return new InlineResponse20014.fromJson(value);
        case 'InlineResponse20015':
          return new InlineResponse20015.fromJson(value);
        case 'InlineResponse20016':
          return new InlineResponse20016.fromJson(value);
        case 'InlineResponse20017':
          return new InlineResponse20017.fromJson(value);
        case 'InlineResponse20018':
          return new InlineResponse20018.fromJson(value);
        case 'InlineResponse20019':
          return new InlineResponse20019.fromJson(value);
        case 'InlineResponse2002':
          return new InlineResponse2002.fromJson(value);
        case 'InlineResponse20020':
          return new InlineResponse20020.fromJson(value);
        case 'InlineResponse20020Data':
          return new InlineResponse20020Data.fromJson(value);
        case 'InlineResponse20021':
          return new InlineResponse20021.fromJson(value);
        case 'InlineResponse20021Data':
          return new InlineResponse20021Data.fromJson(value);
        case 'InlineResponse20022':
          return new InlineResponse20022.fromJson(value);
        case 'InlineResponse20022Data':
          return new InlineResponse20022Data.fromJson(value);
        case 'InlineResponse20023':
          return new InlineResponse20023.fromJson(value);
        case 'InlineResponse20024':
          return new InlineResponse20024.fromJson(value);
        case 'InlineResponse20025':
          return new InlineResponse20025.fromJson(value);
        case 'InlineResponse20026':
          return new InlineResponse20026.fromJson(value);
        case 'InlineResponse20027':
          return new InlineResponse20027.fromJson(value);
        case 'InlineResponse20028':
          return new InlineResponse20028.fromJson(value);
        case 'InlineResponse2003':
          return new InlineResponse2003.fromJson(value);
        case 'InlineResponse2004':
          return new InlineResponse2004.fromJson(value);
        case 'InlineResponse2005':
          return new InlineResponse2005.fromJson(value);
        case 'InlineResponse2006':
          return new InlineResponse2006.fromJson(value);
        case 'InlineResponse2007':
          return new InlineResponse2007.fromJson(value);
        case 'InlineResponse2007Data':
          return new InlineResponse2007Data.fromJson(value);
        case 'InlineResponse2008':
          return new InlineResponse2008.fromJson(value);
        case 'InlineResponse2008Data':
          return new InlineResponse2008Data.fromJson(value);
        case 'InlineResponse2009':
          return new InlineResponse2009.fromJson(value);
        case 'InlineResponse200Data':
          return new InlineResponse200Data.fromJson(value);
        case 'Meeting':
          return new Meeting.fromJson(value);
        case 'MeetingRequestDto':
          return new MeetingRequestDto.fromJson(value);
        case 'MeetingUsers':
          return new MeetingUsers.fromJson(value);
        case 'NotificationDto':
          return new NotificationDto.fromJson(value);
        case 'ParentChild':
          return new ParentChild.fromJson(value);
        case 'ParentTeacherConnectionDto':
          return new ParentTeacherConnectionDto.fromJson(value);
        case 'ParentTeacherConnectionRequestDto':
          return new ParentTeacherConnectionRequestDto.fromJson(value);
        case 'ProfileCompletionVm':
          return new ProfileCompletionVm.fromJson(value);
        case 'RegisterMeetingEntryVm':
          return new RegisterMeetingEntryVm.fromJson(value);
        case 'ReportDetail':
          return new ReportDetail.fromJson(value);
        case 'ReportListItemDto':
          return new ReportListItemDto.fromJson(value);
        case 'ReportParentCommentVm':
          return new ReportParentCommentVm.fromJson(value);
        case 'ReportSubjectGradeDto':
          return new ReportSubjectGradeDto.fromJson(value);
        case 'SearchContactDto':
          return new SearchContactDto.fromJson(value);
        case 'SetTeacherAvailabilityVm':
          return new SetTeacherAvailabilityVm.fromJson(value);
        case 'StudentSearchResult':
          return new StudentSearchResult.fromJson(value);
        case 'SubjectDto':
          return new SubjectDto.fromJson(value);
        case 'TeacherAvailability':
          return new TeacherAvailability.fromJson(value);
        case 'TeacherTellUsMoreVm':
          return new TeacherTellUsMoreVm.fromJson(value);
        case 'UpdateMeetingStatusVm':
          return new UpdateMeetingStatusVm.fromJson(value);
        case 'User':
          return new User.fromJson(value);
        case 'UserEditVm':
          return new UserEditVm.fromJson(value);
        case 'UserSearchResultDto':
          return new UserSearchResultDto.fromJson(value);
        case 'UserSignupVm':
          return new UserSignupVm.fromJson(value);
        default:
          {
            Match match;
            if (value is List &&
                (match = _RegList.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return value.map((v) => _deserialize(v, newTargetType)).toList();
            } else if (value is Map &&
                (match = _RegMap.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return new Map.fromIterables(value.keys,
                  value.values.map((v) => _deserialize(v, newTargetType)));
            }
          }
      }
    } catch (e, stack) {
      throw new ApiException.withInner(
          500, 'Exception during deserialization.', e, stack);
    }
    throw new ApiException(
        500, 'Could not find a suitable class for deserialization');
  }

  dynamic deserialize(String jsonVal, String targetType) {
    // Remove all spaces.  Necessary for reg expressions as well.
    targetType = targetType.replaceAll(' ', '');

    if (targetType == 'String') return jsonVal;

    var decodedJson = json.decode(jsonVal);
    return _deserialize(decodedJson, targetType);
  }

  String serialize(Object obj) {
    String serialized = '';
    if (obj == null) {
      serialized = '';
    } else {
      serialized = json.encode(obj);
    }
    return serialized;
  }

  // We don't use a Map<String, String> for queryParams.
  // If collectionFormat is 'multi' a key might appear multiple times.
  Future<Response> invokeAPI(
      String path,
      String method,
      Iterable<QueryParam> queryParams,
      Object body,
      Map<String, String> headerParams,
      Map<String, String> formParams,
      String contentType,
      List<String> authNames) async {
    _updateParamsForAuth(authNames, queryParams, headerParams);

    var ps = queryParams
        .where((p) => p.value != null)
        .map((p) => '${p.name}=${Uri.encodeQueryComponent(p.value)}');
    String queryString = ps.isNotEmpty ? '?' + ps.join('&') : '';

    String url = basePath + path + queryString;

    print("url---${url}");

    headerParams.addAll(_defaultHeaderMap);
    headerParams['Content-Type'] = contentType;

    if (body is MultipartRequest) {
      var request = new MultipartRequest(method, Uri.parse(url));
      request.fields.addAll(body.fields);
      request.files.addAll(body.files);
      request.headers.addAll(body.headers);
      request.headers.addAll(headerParams);
      var response = await client.send(request);
      return Response.fromStream(response);
    } else {
      var msgBody = contentType == "application/x-www-form-urlencoded"
          ? formParams
          : serialize(body);
      switch (method) {
        case "POST":
          return client.post(Uri.parse(url), headers: headerParams, body: msgBody);
        case "PUT":
          return client.put(Uri.parse(url), headers: headerParams, body: msgBody);
        case "DELETE":
          return client.delete(Uri.parse(url), headers: headerParams);
        case "PATCH":
          return client.patch(Uri.parse(url), headers: headerParams, body: msgBody);
        default:
          return client.get(Uri.parse(url), headers: headerParams);
      }
    }
  }

  /// Update query and header parameters based on authentication settings.
  /// @param authNames The authentications to apply
  void _updateParamsForAuth(List<String> authNames,
      List<QueryParam> queryParams, Map<String, String> headerParams) {
    authNames.forEach((authName) {
      Authentication auth = _authentications[authName];
      if (auth == null)
        throw new ArgumentError("Authentication undefined: " + authName);
      auth.applyToParams(queryParams, headerParams);
    });
  }

  void setAccessToken(String accessToken) {
    _authentications.forEach((key, auth) {
      if (auth is OAuth) {
        auth.setAccessToken(accessToken);
      }
    });
  }
}
