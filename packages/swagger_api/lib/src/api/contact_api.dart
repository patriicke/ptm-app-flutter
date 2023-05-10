part of '../api.dart';

class ContactApi {
  final ApiClient apiClient;

  ContactApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  /// Search for users
  ///
  /// Retrieves a list of users
  Future<InlineResponse20023> searchUsers(String authKey,
      {int userType, String userName}) async {
    Object postBody = null;

    // verify required params are set
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }

    // create path and map variables
    String path = "/users/index.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if (userType != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "userType", userType));
    }
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "authKey", authKey));
    if (userName != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "userName", userName));
    }

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
      return apiClient.deserialize(response.body, 'InlineResponse20023')
          as InlineResponse20023;
    } else {
      return null;
    }
  }
}
