# swagger.api.ContactApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://ptameetings.com/service/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**searchUsers**](ContactApi.md#searchUsers) | **GET** /users/index.php | Search for users


# **searchUsers**
> InlineResponse20015 searchUsers(authKey, userType, userName)

Search for users

Retrieves a list of users

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ContactApi();
var authKey = authKey_example; // String | Authentication key for the user
var userType = 56; // int | If this value is not provided, API **MUST** return all types of users.   Parents(0), Teachers(1)
var userName = userName_example; // String | Search query string for user. If no value is provied, API **MUST** return a list of all users related to this user.

try { 
    var result = api_instance.searchUsers(authKey, userType, userName);
    print(result);
} catch (e) {
    print("Exception when calling ContactApi->searchUsers: $e\n");
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

