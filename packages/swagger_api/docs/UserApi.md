# swagger.api.UserApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://ptameetings.com/service/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addUser**](UserApi.md#addUser) | **POST** /users/signup.php | Register a new user
[**completeUserSignup**](UserApi.md#completeUserSignup) | **POST** /users/signUp/completeProfile.php | 
[**getInviteLink**](UserApi.md#getInviteLink) | **GET** /users/invite | 
[**getParentContactDetails**](UserApi.md#getParentContactDetails) | **GET** /users/contact/parent | 
[**getTeacherContactDetails**](UserApi.md#getTeacherContactDetails) | **GET** /users/contact/teacher | 
[**getUserById**](UserApi.md#getUserById) | **GET** /users/user | Get user by user id
[**loginUser**](UserApi.md#loginUser) | **GET** /users/login | Logs user into the system
[**logoutUser**](UserApi.md#logoutUser) | **GET** /users/logout | Logs out current logged in user session
[**registerParentChildren**](UserApi.md#registerParentChildren) | **POST** /users/signUp/parent/registerChildren.php | 
[**registerParentTeacherConnections**](UserApi.md#registerParentTeacherConnections) | **POST** /users/signUp/parent/registerTeacherConnections.php | 
[**searchUsers**](UserApi.md#searchUsers) | **GET** /users/index.php | Search for users
[**sendEmailInvite**](UserApi.md#sendEmailInvite) | **POST** /users/invite | 
[**teacherUserSignupTellUsMore**](UserApi.md#teacherUserSignupTellUsMore) | **POST** /users/signUp/teacher/tellUsMore.php | Submit &#39;Tell Us More&#39; information for teachers.
[**updateUser**](UserApi.md#updateUser) | **PUT** /users/user | Edit user details
[**verifyUserLogin**](UserApi.md#verifyUserLogin) | **GET** /users/login/verify | 
[**verifyUserSignup**](UserApi.md#verifyUserSignup) | **GET** /users/signUp/verify.php | 


# **addUser**
> InlineResponse20012 addUser(body)

Register a new user

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var body = new UserSignupVm(); // UserSignupVm | User object that needs to be registered

try { 
    var result = api_instance.addUser(body);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->addUser: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**UserSignupVm**](UserSignupVm.md)| User object that needs to be registered | 

### Return type

[**InlineResponse20012**](InlineResponse20012.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **completeUserSignup**
> ApiResponse completeUserSignup(userId, authKey, body)



Successful operation for teachers users will result in their status being updated to 'teacherProfileCompleted'.   Successful operation for parent users will result in their status being updated to 'parentProfileCompleted'.  

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var userId = userId_example; // String | 
var authKey = authKey_example; // String | Authentication key for the user
var body = new ProfileCompletionVm(); // ProfileCompletionVm | 

try { 
    var result = api_instance.completeUserSignup(userId, authKey, body);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->completeUserSignup: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **authKey** | **String**| Authentication key for the user | 
 **body** | [**ProfileCompletionVm**](ProfileCompletionVm.md)|  | 

### Return type

[**ApiResponse**](ApiResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getInviteLink**
> InlineResponse2002 getInviteLink(userId, authKey)



Fetch an invite link

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var userId = userId_example; // String | 
var authKey = authKey_example; // String | 

try { 
    var result = api_instance.getInviteLink(userId, authKey);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->getInviteLink: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **authKey** | **String**|  | 

### Return type

[**InlineResponse2002**](InlineResponse2002.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getParentContactDetails**
> InlineResponse2001 getParentContactDetails(userId, authKey, contactUserId)



Get details of a parent contact

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var userId = userId_example; // String | 
var authKey = authKey_example; // String | 
var contactUserId = contactUserId_example; // String | 

try { 
    var result = api_instance.getParentContactDetails(userId, authKey, contactUserId);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->getParentContactDetails: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **authKey** | **String**|  | 
 **contactUserId** | **String**|  | 

### Return type

[**InlineResponse2001**](InlineResponse2001.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTeacherContactDetails**
> InlineResponse200 getTeacherContactDetails(userId, authKey, contactUserId)



Get details of a teacher contact

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var userId = userId_example; // String | 
var authKey = authKey_example; // String | 
var contactUserId = contactUserId_example; // String | 

try { 
    var result = api_instance.getTeacherContactDetails(userId, authKey, contactUserId);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->getTeacherContactDetails: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **authKey** | **String**|  | 
 **contactUserId** | **String**|  | 

### Return type

[**InlineResponse200**](InlineResponse200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserById**
> InlineResponse20016 getUserById(userId, authKey)

Get user by user id

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var userId = userId_example; // String | The id that needs to be fetched
var authKey = authKey_example; // String | Authentication key for the user

try { 
    var result = api_instance.getUserById(userId, authKey);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->getUserById: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**| The id that needs to be fetched | 
 **authKey** | **String**| Authentication key for the user | 

### Return type

[**InlineResponse20016**](InlineResponse20016.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **loginUser**
> InlineResponse20014 loginUser(email, password)

Logs user into the system



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var email = email_example; // String | The email address of the user for login
var password = password_example; // String | The password for login in clear text

try { 
    var result = api_instance.loginUser(email, password);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->loginUser: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **email** | **String**| The email address of the user for login | 
 **password** | **String**| The password for login in clear text | 

### Return type

[**InlineResponse20014**](InlineResponse20014.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **logoutUser**
> ApiResponse logoutUser(authKey)

Logs out current logged in user session



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var authKey = authKey_example; // String | Authentication key for the user

try { 
    var result = api_instance.logoutUser(authKey);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->logoutUser: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authKey** | **String**| Authentication key for the user | 

### Return type

[**ApiResponse**](ApiResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **registerParentChildren**
> ApiResponse registerParentChildren(userId, authKey, body)



Successful operation will result in parent user's status being updated to 'parentChildrenSubmitted'.

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var userId = userId_example; // String | Id of the parent user to add children to
var authKey = authKey_example; // String | Authentication key for the user
var body = [new List&lt;ParentChild&gt;()]; // List<ParentChild> | The list of children to be registered to the parent

try { 
    var result = api_instance.registerParentChildren(userId, authKey, body);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->registerParentChildren: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**| Id of the parent user to add children to | 
 **authKey** | **String**| Authentication key for the user | 
 **body** | [**List&lt;ParentChild&gt;**](ParentChild.md)| The list of children to be registered to the parent | 

### Return type

[**ApiResponse**](ApiResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **registerParentTeacherConnections**
> ApiResponse registerParentTeacherConnections(userId, authKey, body)



Successful operation will result in the parent user's status being updated to 'parentTeachersConnected'.

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var userId = userId_example; // String | Id of the parent user to connect teachers to
var authKey = authKey_example; // String | Authentication key for the user
var body = [new List&lt;ParentTeacherConnectionDto&gt;()]; // List<ParentTeacherConnectionDto> | The list of teachers to be connected to the parent

try { 
    var result = api_instance.registerParentTeacherConnections(userId, authKey, body);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->registerParentTeacherConnections: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**| Id of the parent user to connect teachers to | 
 **authKey** | **String**| Authentication key for the user | 
 **body** | [**List&lt;ParentTeacherConnectionDto&gt;**](ParentTeacherConnectionDto.md)| The list of teachers to be connected to the parent | 

### Return type

[**ApiResponse**](ApiResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchUsers**
> InlineResponse20015 searchUsers(authKey, userType, userName)

Search for users

Retrieves a list of users

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var authKey = authKey_example; // String | Authentication key for the user
var userType = 56; // int | If this value is not provided, API **MUST** return all types of users.   Parents(0), Teachers(1)
var userName = userName_example; // String | Search query string for user. If no value is provied, API **MUST** return a list of all users related to this user.

try { 
    var result = api_instance.searchUsers(authKey, userType, userName);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->searchUsers: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authKey** | **String**| Authentication key for the user | 
 **userType** | **int**| If this value is not provided, API **MUST** return all types of users.   Parents(0), Teachers(1) | [optional] 
 **userName** | **String**| Search query string for user. If no value is provied, API **MUST** return a list of all users related to this user. | [optional] 

### Return type

[**InlineResponse20015**](InlineResponse20015.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendEmailInvite**
> ApiResponse sendEmailInvite(userId, authKey, toEmail)



Send an email invite

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var userId = userId_example; // String | 
var authKey = authKey_example; // String | 
var toEmail = toEmail_example; // String | 

try { 
    var result = api_instance.sendEmailInvite(userId, authKey, toEmail);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->sendEmailInvite: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **authKey** | **String**|  | 
 **toEmail** | **String**|  | 

### Return type

[**ApiResponse**](ApiResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **teacherUserSignupTellUsMore**
> ApiResponse teacherUserSignupTellUsMore(userId, authKey, body)

Submit 'Tell Us More' information for teachers.

Successful operation will result in teahcer user's status being updated to 'teacherInfoSubmitted'.

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var userId = userId_example; // String | 
var authKey = authKey_example; // String | Authentication key for the user
var body = new TeacherTellUsMoreVm(); // TeacherTellUsMoreVm | 

try { 
    var result = api_instance.teacherUserSignupTellUsMore(userId, authKey, body);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->teacherUserSignupTellUsMore: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **authKey** | **String**| Authentication key for the user | 
 **body** | [**TeacherTellUsMoreVm**](TeacherTellUsMoreVm.md)|  | 

### Return type

[**ApiResponse**](ApiResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateUser**
> InlineResponse20017 updateUser(userId, authKey, body)

Edit user details

This can only be done by the logged in user.

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var userId = userId_example; // String | id of the user that will be updated
var authKey = authKey_example; // String | Authentication key for the user
var body = new UserEditVm(); // UserEditVm | Updated user details

try { 
    var result = api_instance.updateUser(userId, authKey, body);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->updateUser: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**| id of the user that will be updated | 
 **authKey** | **String**| Authentication key for the user | 
 **body** | [**UserEditVm**](UserEditVm.md)| Updated user details | 

### Return type

[**InlineResponse20017**](InlineResponse20017.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **verifyUserLogin**
> InlineResponse20013 verifyUserLogin(userId, loginEventId, oneTimePasscode)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var userId = userId_example; // String | 
var loginEventId = loginEventId_example; // String | Unique identifier of the login event that is provided in the '/users/login' success response
var oneTimePasscode = oneTimePasscode_example; // String | 

try { 
    var result = api_instance.verifyUserLogin(userId, loginEventId, oneTimePasscode);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->verifyUserLogin: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **loginEventId** | **String**| Unique identifier of the login event that is provided in the &#39;/users/login&#39; success response | 
 **oneTimePasscode** | **String**|  | 

### Return type

[**InlineResponse20013**](InlineResponse20013.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **verifyUserSignup**
> InlineResponse20013 verifyUserSignup(userId, signupEventId, oneTimePasscode)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var userId = userId_example; // String | 
var signupEventId = signupEventId_example; // String | Unique identifier of the signup event that is provided in the '/users/signUp' success response
var oneTimePasscode = oneTimePasscode_example; // String | 

try { 
    var result = api_instance.verifyUserSignup(userId, signupEventId, oneTimePasscode);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->verifyUserSignup: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **signupEventId** | **String**| Unique identifier of the signup event that is provided in the &#39;/users/signUp&#39; success response | 
 **oneTimePasscode** | **String**|  | 

### Return type

[**InlineResponse20013**](InlineResponse20013.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

