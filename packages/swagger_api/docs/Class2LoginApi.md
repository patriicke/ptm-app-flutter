# swagger.api.Class2LoginApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://ptameetings.com/service/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**loginUser**](Class2LoginApi.md#loginUser) | **GET** /users/login | Logs user into the system
[**verifyUserLogin**](Class2LoginApi.md#verifyUserLogin) | **GET** /users/login/verify | 


# **loginUser**
> InlineResponse20014 loginUser(email, password)

Logs user into the system



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class2LoginApi();
var email = email_example; // String | The email address of the user for login
var password = password_example; // String | The password for login in clear text

try { 
    var result = api_instance.loginUser(email, password);
    print(result);
} catch (e) {
    print("Exception when calling Class2LoginApi->loginUser: $e\n");
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

# **verifyUserLogin**
> InlineResponse20013 verifyUserLogin(userId, loginEventId, oneTimePasscode)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class2LoginApi();
var userId = userId_example; // String | 
var loginEventId = loginEventId_example; // String | Unique identifier of the login event that is provided in the '/users/login' success response
var oneTimePasscode = oneTimePasscode_example; // String | 

try { 
    var result = api_instance.verifyUserLogin(userId, loginEventId, oneTimePasscode);
    print(result);
} catch (e) {
    print("Exception when calling Class2LoginApi->verifyUserLogin: $e\n");
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

