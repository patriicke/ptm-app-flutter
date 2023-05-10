part of '../api.dart';

class NotificationApi {
  final ApiClient apiClient;

  NotificationApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  ///
  ///
  /// Fetch a list of the user&#39;s notifications
  Future<InlineResponse20014> getUserNotifications(
      String notificationFilter, String authKey, String userId) async {
    Object postBody = null;

    // verify required params are set
    if (notificationFilter == null) {
      throw new ApiException(400, "Missing required param: notificationFilter");
    }
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (userId == null) {
      throw new ApiException(400, "Missing required param: userId");
    }

    // create path and map variables
    String path = "/notifications.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams.addAll(_convertParametersForCollectionFormat(
        "", "notificationFilter", notificationFilter));
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
      return apiClient.deserialize(response.body, 'InlineResponse20014')
          as InlineResponse20014;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Record a notification&#39;s &#39;seen&#39; status
  Future<InlineResponse20015> seeNotification(
      String authKey, String notificationId) async {
    Object postBody = null;

    // verify required params are set
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (notificationId == null) {
      throw new ApiException(400, "Missing required param: notificationId");
    }

    // create path and map variables
    String path = "/notifications.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "authKey", authKey));
    queryParams.addAll(_convertParametersForCollectionFormat(
        "", "notificationId", notificationId));

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
      return apiClient.deserialize(response.body, 'InlineResponse20015')
          as InlineResponse20015;
    } else {
      return null;
    }
  }
}
