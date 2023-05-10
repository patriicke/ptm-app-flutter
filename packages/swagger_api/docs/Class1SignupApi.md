# swagger.api.Class1SignupApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://ptameetings.com/service/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addUser**](Class1SignupApi.md#addUser) | **POST** /users/signup.php | Register a new user
[**completeUserSignup**](Class1SignupApi.md#completeUserSignup) | **POST** /users/signUp/completeProfile.php | 
[**registerParentChildren**](Class1SignupApi.md#registerParentChildren) | **POST** /users/signUp/parent/registerChildren.php | 
[**registerParentTeacherConnections**](Class1SignupApi.md#registerParentTeacherConnections) | **POST** /users/signUp/parent/registerTeacherConnections.php | 
[**searchUsers**](Class1SignupApi.md#searchUsers) | **GET** /users/index.php | Search for users
[**teacherUserSignupTellUsMore**](Class1SignupApi.md#teacherUserSignupTellUsMore) | **POST** /users/signUp/teacher/tellUsMore.php | Submit &#39;Tell Us More&#39; information for teachers.
[**verifyUserSignup**](Class1SignupApi.md#verifyUserSignup) | **GET** /users/signUp/verify.php | 


# **addUser**
> InlineResponse20012 addUser(body)

Register a new user

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class1SignupApi();
var body = new UserSignupVm(); // UserSignupVm | User object that needs to be registered

try { 
    var result = api_instance.addUser(body);
    print(result);
} catch (e) {
    print("Exception when calling Class1SignupApi->addUser: $e\n");
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

var api_instance = new Class1SignupApi();
var userId = userId_example; // String | 
var authKey = authKey_example; // String | Authentication key for the user
var body = new ProfileCompletionVm(); // ProfileCompletionVm | 

try { 
    var result = api_instance.completeUserSignup(userId, authKey, body);
    print(result);
} catch (e) {
    print("Exception when calling Class1SignupApi->completeUserSignup: $e\n");
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

# **registerParentChildren**
> ApiResponse registerParentChildren(userId, authKey, body)



Successful operation will result in parent user's status being updated to 'parentChildrenSubmitted'.

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class1SignupApi();
var userId = userId_example; // String | Id of the parent user to add children to
var authKey = authKey_example; // String | Authentication key for the user
var body = [new List&lt;ParentChild&gt;()]; // List<ParentChild> | The list of children to be registered to the parent

try { 
    var result = api_instance.registerParentChildren(userId, authKey, body);
    print(result);
} catch (e) {
    print("Exception when calling Class1SignupApi->registerParentChildren: $e\n");
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

var api_instance = new Class1SignupApi();
var userId = userId_example; // String | Id of the parent user to connect teachers to
var authKey = authKey_example; // String | Authentication key for the user
var body = [new List&lt;ParentTeacherConnectionDto&gt;()]; // List<ParentTeacherConnectionDto> | The list of teachers to be connected to the parent

try { 
    var result = api_instance.registerParentTeacherConnections(userId, authKey, body);
    print(result);
} catch (e) {
    print("Exception when calling Class1SignupApi->registerParentTeacherConnections: $e\n");
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

var api_instance = new Class1SignupApi();
var authKey = authKey_example; // String | Authentication key for the user
var userType = 56; // int | If this value is not provided, API **MUST** return all types of users.   Parents(0), Teachers(1)
var userName = userName_example; // String | Search query string for user. If no value is provied, API **MUST** return a list of all users related to this user.

try { 
    var result = api_instance.searchUsers(authKey, userType, userName);
    print(result);
} catch (e) {
    print("Exception when calling Class1SignupApi->searchUsers: $e\n");
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

# **teacherUserSignupTellUsMore**
> ApiResponse teacherUserSignupTellUsMore(userId, authKey, body)

Submit 'Tell Us More' information for teachers.

Successful operation will result in teahcer user's status being updated to 'teacherInfoSubmitted'.

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class1SignupApi();
var userId = userId_example; // String | 
var authKey = authKey_example; // String | Authentication key for the user
var body = new TeacherTellUsMoreVm(); // TeacherTellUsMoreVm | 

try { 
    var result = api_instance.teacherUserSignupTellUsMore(userId, authKey, body);
    print(result);
} catch (e) {
    print("Exception when calling Class1SignupApi->teacherUserSignupTellUsMore: $e\n");
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

# **verifyUserSignup**
> InlineResponse20013 verifyUserSignup(userId, signupEventId, oneTimePasscode)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class1SignupApi();
var userId = userId_example; // String | 
var signupEventId = signupEventId_example; // String | Unique identifier of the signup event that is provided in the '/users/signUp' success response
var oneTimePasscode = oneTimePasscode_example; // String | 

try { 
    var result = api_instance.verifyUserSignup(userId, signupEventId, oneTimePasscode);
    print(result);
} catch (e) {
    print("Exception when calling Class1SignupApi->verifyUserSignup: $e\n");
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

