part of '../api.dart';

class UserApi {
  final ApiClient apiClient;

  UserApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  /// Register a new user
  ///
  ///
  Future<InlineResponse20020> addUser(UserSignupVm body) async {
    Object postBody = body;

    // verify required params are set
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path = "/users/signup.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

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

    log(response.body);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'InlineResponse20020')
          as InlineResponse20020;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Submit verification code and change password
  Future<InlineResponse2001> changePasswordPhpGet(
      String otp, String signupEventId, String password) async {
    Object postBody = null;

    // verify required params are set
    if (otp == null) {
      throw new ApiException(400, "Missing required param: otp");
    }
    if (signupEventId == null) {
      throw new ApiException(400, "Missing required param: signupEventId");
    }
    if (password == null) {
      throw new ApiException(400, "Missing required param: password");
    }

    // create path and map variables
    String path = "/changePassword.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams.addAll(_convertParametersForCollectionFormat("", "otp", otp));
    queryParams.addAll(_convertParametersForCollectionFormat(
        "", "signupEventId", signupEventId));
    queryParams.addAll(
        _convertParametersForCollectionFormat("", "password", password));

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
      return apiClient.deserialize(response.body, 'InlineResponse2001')
          as InlineResponse2001;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Successful operation for teachers users will result in their status being updated to &#39;teacherProfileCompleted&#39;.   Successful operation for parent users will result in their status being updated to &#39;parentProfileCompleted&#39;.
  Future<ApiResponse> completeUserSignup(
      String userId, String authKey, ProfileCompletionVm body) async {
    Object postBody = body;

    // verify required params are set
    if (userId == null) {
      throw new ApiException(400, "Missing required param: userId");
    }
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path =
        "/users/signUp/completeProfile.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "userId", userId));
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
      return apiClient.deserialize(response.body, 'ApiResponse') as ApiResponse;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Get verification code for forgotten password
  Future<InlineResponse200> forgotPhpGet(String email) async {
    Object postBody = null;

    // verify required params are set
    if (email == null) {
      throw new ApiException(400, "Missing required param: email");
    }

    // create path and map variables
    String path = "/forgot.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "email", email));

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
      return apiClient.deserialize(response.body, 'InlineResponse200')
          as InlineResponse200;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Fetch an invite link
  Future<InlineResponse2009> getInviteLink(
      String userId, String authKey) async {
    Object postBody = null;

    // verify required params are set
    if (userId == null) {
      throw new ApiException(400, "Missing required param: userId");
    }
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }

    // create path and map variables
    String path = "/users/invite.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "userId", userId));
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
      return apiClient.deserialize(response.body, 'InlineResponse2009')
          as InlineResponse2009;
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

  /// Get user by user id
  ///
  ///
  Future<InlineResponse20024> getUserById(String userId, String authKey) async {
    Object postBody = null;

    // verify required params are set
    if (userId == null) {
      throw new ApiException(400, "Missing required param: userId");
    }
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }

    // create path and map variables
    String path = "/users/user.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "userId", userId));
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

    print("user_response---${response.body}");

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'InlineResponse20024')
          as InlineResponse20024;
    } else {
      return null;
    }
  }

  /// Logs user into the system
  ///
  ///
  Future<InlineResponse20022> loginUser(String email, String password) async {
    Object postBody = null;

    // verify required params are set
    if (email == null) {
      throw new ApiException(400, "Missing required param: email");
    }
    if (password == null) {
      throw new ApiException(400, "Missing required param: password");
    }

    // create path and map variables
    String path = "/users/login.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "email", email));
    queryParams.addAll(
        _convertParametersForCollectionFormat("", "password", password));

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

    print("response---${response.body}");

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'InlineResponse20022')
          as InlineResponse20022;
    } else {
      return null;
    }
  }

  /// Logs out current logged in user session
  ///
  ///
  Future<ApiResponse> logoutUser(String authKey) async {
    Object postBody = null;

    // verify required params are set
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }

    // create path and map variables
    String path = "/users/logout.php".replaceAll("{format}", "json");

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
      return apiClient.deserialize(response.body, 'ApiResponse') as ApiResponse;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Successful operation will result in parent user&#39;s status being updated to &#39;parentChildrenSubmitted&#39;.
  Future<ApiResponse> registerParentChildren(
      String userId, String authKey, List<ParentChild> body) async {
    Object postBody = body;

    // verify required params are set
    if (userId == null) {
      throw new ApiException(400, "Missing required param: userId");
    }
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path = "/users/signUp/parent/registerChildren.php"
        .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "userId", userId));
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
      return apiClient.deserialize(response.body, 'ApiResponse') as ApiResponse;
    } else {
      return null;
    }
  }

  ///
  ///
  /// Successful operation will result in the parent user&#39;s status being updated to &#39;parentTeachersConnected&#39;.
  Future<ApiResponse> registerParentTeacherConnections(String userId,
      String authKey, List<ParentTeacherConnectionDto> body) async {
    Object postBody = body;

    // verify required params are set
    if (userId == null) {
      throw new ApiException(400, "Missing required param: userId");
    }
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path = "/users/signUp/parent/registerTeacherConnections.php"
        .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "userId", userId));
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
      return apiClient.deserialize(response.body, 'ApiResponse') as ApiResponse;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future<InlineResponse20021> resendVerificationCode(
      String userId, String signupEventId) async {
    Object postBody = null;

    // verify required params are set
    if (userId == null) {
      throw new ApiException(400, "Missing required param: userId");
    }
    if (signupEventId == null) {
      throw new ApiException(400, "Missing required param: signupEventId");
    }

    // create path and map variables
    String path =
        "/users/signUp/resendVerification.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "userId", userId));
    queryParams.addAll(_convertParametersForCollectionFormat(
        "", "signupEventId", signupEventId));

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
      return apiClient.deserialize(response.body, 'InlineResponse20021')
          as InlineResponse20021;
    } else {
      return null;
    }
  }

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

  ///
  ///
  /// Send an email invite
  Future<ApiResponse> sendEmailInvite(
      String userId, String authKey, String toEmail) async {
    Object postBody = null;

    // verify required params are set
    if (userId == null) {
      throw new ApiException(400, "Missing required param: userId");
    }
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (toEmail == null) {
      throw new ApiException(400, "Missing required param: toEmail");
    }

    // create path and map variables
    String path = "/users/invite.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "userId", userId));
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "authKey", authKey));
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "toEmail", toEmail));

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
      return apiClient.deserialize(response.body, 'ApiResponse') as ApiResponse;
    } else {
      return null;
    }
  }

  /// Submit &#39;Tell Us More&#39; information for teachers.
  ///
  /// Successful operation will result in teahcer user&#39;s status being updated to &#39;teacherInfoSubmitted&#39;.
  Future<ApiResponse> teacherUserSignupTellUsMore(
      String userId, String authKey, TeacherTellUsMoreVm body) async {
    Object postBody = body;

    // verify required params are set
    if (userId == null) {
      throw new ApiException(400, "Missing required param: userId");
    }
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path =
        "/users/signUp/teacher/tellUsMore.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "userId", userId));
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
      return apiClient.deserialize(response.body, 'ApiResponse') as ApiResponse;
    } else {
      return null;
    }
  }

  /// Edit user details
  ///
  /// This can only be done by the logged in user.
  Future<InlineResponse20025> updateUser(
      String userId, String authKey, UserEditVm body) async {
    Object postBody = body;

    // verify required params are set
    if (userId == null) {
      throw new ApiException(400, "Missing required param: userId");
    }
    if (authKey == null) {
      throw new ApiException(400, "Missing required param: authKey");
    }
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path = "/users/user.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "userId", userId));
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
      return apiClient.deserialize(response.body, 'InlineResponse20025')
          as InlineResponse20025;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future<InlineResponse20021> verifyUserSignup(
      String userId, String signupEventId, String oneTimePasscode) async {
    Object postBody = null;

    // verify required params are set
    if (userId == null) {
      throw new ApiException(400, "Missing required param: userId");
    }
    if (signupEventId == null) {
      throw new ApiException(400, "Missing required param: signupEventId");
    }
    if (oneTimePasscode == null) {
      throw new ApiException(400, "Missing required param: oneTimePasscode");
    }

    // create path and map variables
    String path = "/users/signUp/verify.php".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    queryParams
        .addAll(_convertParametersForCollectionFormat("", "userId", userId));
    queryParams.addAll(_convertParametersForCollectionFormat(
        "", "signupEventId", signupEventId));
    queryParams.addAll(_convertParametersForCollectionFormat(
        "", "oneTimePasscode", oneTimePasscode));

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
      return apiClient.deserialize(response.body, 'InlineResponse20021')
          as InlineResponse20021;
    } else {
      return null;
    }
  }
}
