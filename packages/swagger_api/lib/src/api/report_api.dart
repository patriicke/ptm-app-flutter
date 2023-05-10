part of '../api.dart';

class ReportApi {
  final ApiClient apiClient;

  ReportApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///
  ///
  /// Create a new report
  Future<InlineResponse20018> createNewReport(
      String authKey, CreateEditReportVm body) async {
    Object postBody = body;

    // verify required params are set
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path = "/reports.php".replaceAll("{format}", "json");

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
      return apiClient.deserialize(response.body, 'InlineResponse20018')
          as InlineResponse20018;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Edit an existing report
  Future<InlineResponse20018> editReport(
      String authKey, String reportId, CreateEditReportVm body) async {
    Object postBody = body;

    // verify required params are set
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (reportId == null) {
      throw new ApiException(400, "Missing required param: reportId");
    }
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path = "/reports/report.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "authKey", authKey));
    queryParams.addAll(
        _convertParametersForCollectionFormat("", "reportId", reportId));

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
      return apiClient.deserialize(response.body, 'InlineResponse20018')
          as InlineResponse20018;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Get details of an existing report
  Future<InlineResponse20018> getReportDetail(
      String authKey, String reportId) async {
    Object postBody = null;

    // verify required params are set
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (reportId == null) {
      throw new ApiException(400, "Missing required param: reportId");
    }

    // create path and map variables
    String path = "/reports/report.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "authKey", authKey));
    queryParams.addAll(
        _convertParametersForCollectionFormat("", "reportId", reportId));

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
      return apiClient.deserialize(response.body, 'InlineResponse20018')
          as InlineResponse20018;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Get a list of reports
  Future<InlineResponse20019> getReportList(String authKey) async {
    Object postBody = null;

    // verify required params are set
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }

    // create path and map variables
    String path = "/reports.php".replaceAll("{format}", "json");

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
      return apiClient.deserialize(response.body, 'InlineResponse20019')
          as InlineResponse20019;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Function for parents to leave a comment on an existing report
  Future<InlineResponse20018> rateReport(String authKey, String reportId,
      {ReportParentCommentVm body}) async {
    Object postBody = body;

    // verify required params are set
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (reportId == null) {
      throw new ApiException(400, "Missing required param: reportId");
    }

    // create path and map variables
    String path = "/reports/rating.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "authKey", authKey));
    queryParams.addAll(
        _convertParametersForCollectionFormat("", "reportId", reportId));

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
      return apiClient.deserialize(response.body, 'InlineResponse20018')
          as InlineResponse20018;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Search for a student
  Future<InlineResponse20017> studentsPhpGet(String authKey,
      {String userName}) async {
    Object postBody = null;

    // verify required params are set
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }

    // create path and map variables
    String path = "/students.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
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
      return apiClient.deserialize(response.body, 'InlineResponse20017')
          as InlineResponse20017;
    } else {
      return null;
    }
  }
}
