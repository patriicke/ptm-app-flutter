part of '../api.dart';

class TypesApi {
  final ApiClient apiClient;

  TypesApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///
  ///
  /// Get a list of cities
  Future<InlineResponse2004> cityPhpGet() async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/city.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

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

    print("city_response$response");

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'InlineResponse2004')
          as InlineResponse2004;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Get a list of grades
  Future<InlineResponse2003> gradePhpGet() async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/grade.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

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
      return apiClient.deserialize(response.body, 'InlineResponse2003')
          as InlineResponse2003;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Get a list of subjects
  Future<InlineResponse2002> subjectPhpGet() async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/subject.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

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
      return apiClient.deserialize(response.body, 'InlineResponse2002')
          as InlineResponse2002;
    } else {
      return null;
    }
  }
}
