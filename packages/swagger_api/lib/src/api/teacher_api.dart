part of '../api.dart';

class TeacherApi {
  final ApiClient apiClient;

  TeacherApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///
  ///
  /// Get list of teacher&#39;s availability
  Future<InlineResponse20016> getTeacherAvailability(
      String authKey, String userId, String availabilityType) async {
    Object postBody = null;

    // verify required params are set
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (userId == null) {
      throw new ApiException(400, "Missing required param: userId");
    }
    if (availabilityType == null) {
      throw new ApiException(400, "Missing required param: availabilityType");
    }

    // create path and map variables
    String path = "/teacher/availability.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "authKey", authKey));
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "userId", userId));
    queryParams.addAll(_convertParametersForCollectionFormat(
        "", "availabilityType", availabilityType));

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
      return apiClient.deserialize(response.body, 'InlineResponse20016')
          as InlineResponse20016;
    } else {
      return null;
    }
  }

  /// Get teacher&#39;s connection requests
  ///
  ///
  Future<InlineResponse2006> getTeacherConnectionRequests(
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
    String path = "/teacher/connections.php".replaceAll("{format}", "json");

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
      return apiClient.deserialize(response.body, 'InlineResponse2006')
          as InlineResponse2006;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Set teacher&#39;s availability for a given date
  Future<InlineResponse20016> setTeacherAvailability(
      String authKey, String userId, SetTeacherAvailabilityVm body) async {
    Object postBody = body;

    // verify required params are set
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (userId == null) {
      throw new ApiException(400, "Missing required param: userId");
    }
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path = "/teacher/availability.php".replaceAll("{format}", "json");

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

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'InlineResponse20016')
          as InlineResponse20016;
    } else {
      return null;
    }
  }

  /// Accept or reject a parent-teacher connection
  ///
  ///
  Future<InlineResponse2001> updateConnectionStatus(String connectionRequestId,
      String authKey, String userId, int newStatus) async {
    Object postBody = null;

    // verify required params are set
    if (connectionRequestId == null) {
      throw new ApiException(
          400, "Missing required param: connectionRequestId");
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
    String path = "/teacher/connections.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams.addAll(_convertParametersForCollectionFormat(
        "", "connectionRequestId", connectionRequestId));
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

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'InlineResponse2001')
          as InlineResponse2001;
    } else {
      return null;
    }
  }
}
