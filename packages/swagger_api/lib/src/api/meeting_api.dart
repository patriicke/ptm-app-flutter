part of '../api.dart';

class MeetingApi {
  final ApiClient apiClient;

  MeetingApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///
  ///
  ///
  Future<InlineResponse20027> createNewMeeting(
      String authKey, CreateMeetingVm body) async {
    Object postBody = body;

    // verify required params are set
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path = "/meetings.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "authKey", authKey));

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'InlineResponse20027')
          as InlineResponse20027;
    } else {
      return null;
    }
  }

  /// Get user&#39;s meeting requests
  ///
  ///
  Future<InlineResponse2005> getMeetingRequests(
      String authKey, String userId) async {
    Object postBody = null;

    // verify required params are set
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (userId == null) {
      throw new ApiException(400, "Missing required param: userId");
    }

    // create path and map variables
    String path = "/meetings/requests.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "authKey", authKey));
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "userId", userId));

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'InlineResponse2005')
          as InlineResponse2005;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future<InlineResponse20026> getMeetings(String authKey) async {
    Object postBody = null;

    // verify required params are set
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }

    // create path and map variables
    String path = "/meetings.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "authKey", authKey));

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'InlineResponse20026')
          as InlineResponse20026;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Retrieves a list of meetings that the user had previously attended.   **NOTE** *lastEnteredOn* field MUST NOT be null or empty for any of the meetings returned.
  Future<InlineResponse20026> meetingsAttendedPhpGet(String authKey) async {
    Object postBody = null;

    // verify required params are set
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }

    // create path and map variables
    String path = "/meetings/attended.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "authKey", authKey));

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'InlineResponse20026')
          as InlineResponse20026;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Log event for user entering a meeting
  Future<InlineResponse20027> registerMeetingEntry(
      String meetingId, String authKey,
      {RegisterMeetingEntryVm body}) async {
    Object postBody = body;

    // verify required params are set
    if (meetingId == null) {
      throw new ApiException(400, "Missing required param: meetingId");
    }
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }

    // create path and map variables
    String path = "/meetings/registerEntry.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams.addAll(
        _convertParametersForCollectionFormat("", "meetingId", meetingId));
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "authKey", authKey));

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'PUT', queryParams, postBody,
        headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'InlineResponse20027')
          as InlineResponse20027;
    } else {
      return null;
    }
  }

  ///
  ///
  /// This endpoint is called by UI when users Accept or Reject a meeting.
  Future<InlineResponse20028> updateMeetingAttendanceStatus(
      String meetingId, String authKey, String userId, int newStatus) async {
    Object postBody = null;

    // verify required params are set
    if (meetingId == null) {
      throw new ApiException(400, "Missing required param: meetingId");
    }
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (userId == null) {
      throw new ApiException(400, "Missing required param: userId");
    }
    if (newStatus == null) {
      throw new ApiException(400, "Missing required param: newStatus");
    }

    // create path and map variables
    String path =
        "/meetings/updateAttendanceStatus.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams.addAll(
        _convertParametersForCollectionFormat("", "meetingId", meetingId));
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "authKey", authKey));
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "userId", userId));
    queryParams.addAll(
        _convertParametersForCollectionFormat("", "newStatus", newStatus));

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'PUT', queryParams, postBody,
        headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'InlineResponse20028')
          as InlineResponse20028;
    } else {
      return null;
    }
  }
}
