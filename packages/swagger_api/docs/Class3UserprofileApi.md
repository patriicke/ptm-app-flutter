# swagger.api.Class3UserprofileApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://ptameetings.com/service/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getInviteLink**](Class3UserprofileApi.md#getInviteLink) | **GET** /users/invite | 
[**getTeacherAvailability**](Class3UserprofileApi.md#getTeacherAvailability) | **GET** /teacher/availability | 
[**getUserById**](Class3UserprofileApi.md#getUserById) | **GET** /users/user | Get user by user id
[**logoutUser**](Class3UserprofileApi.md#logoutUser) | **GET** /users/logout | Logs out current logged in user session
[**sendEmailInvite**](Class3UserprofileApi.md#sendEmailInvite) | **POST** /users/invite | 
[**setTeacherAvailability**](Class3UserprofileApi.md#setTeacherAvailability) | **POST** /teacher/availability | 
[**updateUser**](Class3UserprofileApi.md#updateUser) | **PUT** /users/user | Edit user details


# **getInviteLink**
> InlineResponse2002 getInviteLink(userId, authKey)



Fetch an invite link

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class3UserprofileApi();
var userId = userId_example; // String | 
var authKey = authKey_example; // String | 

try { 
    var result = api_instance.getInviteLink(userId, authKey);
    print(result);
} catch (e) {
    print("Exception when calling Class3UserprofileApi->getInviteLink: $e\n");
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

# **getTeacherAvailability**
> InlineResponse2008 getTeacherAvailability(authKey, userId, availabilityType)



Get list of teacher's availability

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class3UserprofileApi();
var authKey = authKey_example; // String | Authentication key for the user
var userId = userId_example; // String | 
var availabilityType = availabilityType_example; // String | Filter for type of availability to fetch

try { 
    var result = api_instance.getTeacherAvailability(authKey, userId, availabilityType);
    print(result);
} catch (e) {
    print("Exception when calling Class3UserprofileApi->getTeacherAvailability: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authKey** | **String**| Authentication key for the user | 
 **userId** | **String**|  | 
 **availabilityType** | **String**| Filter for type of availability to fetch | 

### Return type

[**InlineResponse2008**](InlineResponse2008.md)

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

var api_instance = new Class3UserprofileApi();
var userId = userId_example; // String | The id that needs to be fetched
var authKey = authKey_example; // String | Authentication key for the user

try { 
    var result = api_instance.getUserById(userId, authKey);
    print(result);
} catch (e) {
    print("Exception when calling Class3UserprofileApi->getUserById: $e\n");
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

# **logoutUser**
> ApiResponse logoutUser(authKey)

Logs out current logged in user session



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class3UserprofileApi();
var authKey = authKey_example; // String | Authentication key for the user

try { 
    var result = api_instance.logoutUser(authKey);
    print(result);
} catch (e) {
    print("Exception when calling Class3UserprofileApi->logoutUser: $e\n");
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

# **sendEmailInvite**
> ApiResponse sendEmailInvite(userId, authKey, toEmail)



Send an email invite

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class3UserprofileApi();
var userId = userId_example; // String | 
var authKey = authKey_example; // String | 
var toEmail = toEmail_example; // String | 

try { 
    var result = api_instance.sendEmailInvite(userId, authKey, toEmail);
    print(result);
} catch (e) {
    print("Exception when calling Class3UserprofileApi->sendEmailInvite: $e\n");
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

# **setTeacherAvailability**
> InlineResponse2008 setTeacherAvailability(authKey, userId, body)



Set teacher's availability for a given date

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class3UserprofileApi();
var authKey = authKey_example; // String | Authentication key for the user
var userId = userId_example; // String | 
var body = new SetTeacherAvailabilityVm(); // SetTeacherAvailabilityVm | 

try { 
    var result = api_instance.setTeacherAvailability(authKey, userId, body);
    print(result);
} catch (e) {
    print("Exception when calling Class3UserprofileApi->setTeacherAvailability: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authKey** | **String**| Authentication key for the user | 
 **userId** | **String**|  | 
 **body** | [**SetTeacherAvailabilityVm**](SetTeacherAvailabilityVm.md)|  | 

### Return type

[**InlineResponse2008**](InlineResponse2008.md)

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

var api_instance = new Class3UserprofileApi();
var userId = userId_example; // String | id of the user that will be updated
var authKey = authKey_example; // String | Authentication key for the user
var body = new UserEditVm(); // UserEditVm | Updated user details

try { 
    var result = api_instance.updateUser(userId, authKey, body);
    print(result);
} catch (e) {
    print("Exception when calling Class3UserprofileApi->updateUser: $e\n");
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

