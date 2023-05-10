part of '../api.dart';

class ChatApi {
  final ApiClient apiClient;

  ChatApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///
  ///
  /// Fetch a list of other users that the user has previously sent or received messages from
  Future<InlineResponse20013> getChatContacts(
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
    String path = "/chats/contacts.php".replaceAll("{format}", "json");

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
      return apiClient.deserialize(response.body, 'InlineResponse20013')
          as InlineResponse20013;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Fetch a list of messages that the user has sent/received between a specified other user
  Future<InlineResponse20010> getChatMessages(
      String authKey, String userId, String contactUserId) async {
    Object postBody = null;

    // verify required params are set
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (userId == null) {
      throw new ApiException(400, "Missing required param: userId");
    }
    if (contactUserId == null) {
      throw new ApiException(400, "Missing required param: contactUserId");
    }

    // create path and map variables
    String path = "/chats/messages.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "authKey", authKey));
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "userId", userId));
    queryParams.addAll(_convertParametersForCollectionFormat(
        "", "contactUserId", contactUserId));

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
      return apiClient.deserialize(response.body, 'InlineResponse20010')
          as InlineResponse20010;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Get details of a parent contact
  Future<InlineResponse2008> getParentContactDetails(
      String userId, String authKey, String contactUserId) async {
    Object postBody = null;

    // verify required params are set
    if (userId == null) {
      throw new ApiException(400, "Missing required param: userId");
    }
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (contactUserId == null) {
      throw new ApiException(400, "Missing required param: contactUserId");
    }

    // create path and map variables
    String path = "/users/contact/parent.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "userId", userId));
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "authKey", authKey));
    queryParams.addAll(_convertParametersForCollectionFormat(
        "", "contactUserId", contactUserId));

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
      return apiClient.deserialize(response.body, 'InlineResponse2008')
          as InlineResponse2008;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Get details of a teacher contact
  Future<InlineResponse2007> getTeacherContactDetails(
      String userId, String authKey, String contactUserId) async {
    Object postBody = null;

    // verify required params are set
    if (userId == null) {
      throw new ApiException(400, "Missing required param: userId");
    }
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (contactUserId == null) {
      throw new ApiException(400, "Missing required param: contactUserId");
    }

    // create path and map variables
    String path = "/users/contact/teacher.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "userId", userId));
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "authKey", authKey));
    queryParams.addAll(_convertParametersForCollectionFormat(
        "", "contactUserId", contactUserId));

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
      return apiClient.deserialize(response.body, 'InlineResponse2007')
          as InlineResponse2007;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Fetch a list of users to start a new chat with
  Future<InlineResponse20012> searchChatContacts(
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
    String path = "/chats/contacts/search.php".replaceAll("{format}", "json");

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
      return apiClient.deserialize(response.body, 'InlineResponse20012')
          as InlineResponse20012;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Send a new message to contact
  Future<InlineResponse20011> sendMessage(
      String authKey, String userId, String contactUserId,
      {Body body}) async {
    Object postBody = body;

    // verify required params are set
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (userId == null) {
      throw new ApiException(400, "Missing required param: userId");
    }
    if (contactUserId == null) {
      throw new ApiException(400, "Missing required param: contactUserId");
    }

    // create path and map variables
    String path = "/chats/messages.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "authKey", authKey));
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "userId", userId));
    queryParams.addAll(_convertParametersForCollectionFormat(
        "", "contactUserId", contactUserId));

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
      return apiClient.deserialize(response.body, 'InlineResponse20011')
          as InlineResponse20011;
    } else {
      return null;
    }
  }
}
