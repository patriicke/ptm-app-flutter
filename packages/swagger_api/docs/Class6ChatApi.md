# swagger.api.Class6ChatApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://ptameetings.com/service/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getChatContacts**](Class6ChatApi.md#getChatContacts) | **GET** /chats/contacts | 
[**getChatMessages**](Class6ChatApi.md#getChatMessages) | **GET** /chats/messages | 
[**getParentContactDetails**](Class6ChatApi.md#getParentContactDetails) | **GET** /users/contact/parent | 
[**getTeacherContactDetails**](Class6ChatApi.md#getTeacherContactDetails) | **GET** /users/contact/teacher | 
[**meetingsAttendedGet**](Class6ChatApi.md#meetingsAttendedGet) | **GET** /meetings/attended | 
[**sendMessage**](Class6ChatApi.md#sendMessage) | **POST** /chats/messages | 


# **getChatContacts**
> InlineResponse2005 getChatContacts(authKey, userId)



Fetch a list of other users that the user has previously sent or received messages from

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class6ChatApi();
var authKey = authKey_example; // String | 
var userId = userId_example; // String | 

try { 
    var result = api_instance.getChatContacts(authKey, userId);
    print(result);
} catch (e) {
    print("Exception when calling Class6ChatApi->getChatContacts: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authKey** | **String**|  | 
 **userId** | **String**|  | 

### Return type

[**InlineResponse2005**](InlineResponse2005.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getChatMessages**
> InlineResponse2003 getChatMessages(authKey, userId, contactUserId)



Fetch a list of messages that the user has sent/received between a specified other user

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class6ChatApi();
var authKey = authKey_example; // String | 
var userId = userId_example; // String | 
var contactUserId = contactUserId_example; // String | 

try { 
    var result = api_instance.getChatMessages(authKey, userId, contactUserId);
    print(result);
} catch (e) {
    print("Exception when calling Class6ChatApi->getChatMessages: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authKey** | **String**|  | 
 **userId** | **String**|  | 
 **contactUserId** | **String**|  | 

### Return type

[**InlineResponse2003**](InlineResponse2003.md)

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

var api_instance = new Class6ChatApi();
var userId = userId_example; // String | 
var authKey = authKey_example; // String | 
var contactUserId = contactUserId_example; // String | 

try { 
    var result = api_instance.getParentContactDetails(userId, authKey, contactUserId);
    print(result);
} catch (e) {
    print("Exception when calling Class6ChatApi->getParentContactDetails: $e\n");
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

var api_instance = new Class6ChatApi();
var userId = userId_example; // String | 
var authKey = authKey_example; // String | 
var contactUserId = contactUserId_example; // String | 

try { 
    var result = api_instance.getTeacherContactDetails(userId, authKey, contactUserId);
    print(result);
} catch (e) {
    print("Exception when calling Class6ChatApi->getTeacherContactDetails: $e\n");
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

# **meetingsAttendedGet**
> InlineResponse20018 meetingsAttendedGet(authKey)



Retrieves a list of meetings that the user had previously attended.   **NOTE** *lastEnteredOn* field MUST NOT be null or empty for any of the meetings returned.

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class6ChatApi();
var authKey = authKey_example; // String | Authentication key for the user

try { 
    var result = api_instance.meetingsAttendedGet(authKey);
    print(result);
} catch (e) {
    print("Exception when calling Class6ChatApi->meetingsAttendedGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authKey** | **String**| Authentication key for the user | 

### Return type

[**InlineResponse20018**](InlineResponse20018.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendMessage**
> InlineResponse2004 sendMessage(authKey, userId, contactUserId, body)



Send a new message to contact

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class6ChatApi();
var authKey = authKey_example; // String | 
var userId = userId_example; // String | 
var contactUserId = contactUserId_example; // String | 
var body = new Body(); // Body | 

try { 
    var result = api_instance.sendMessage(authKey, userId, contactUserId, body);
    print(result);
} catch (e) {
    print("Exception when calling Class6ChatApi->sendMessage: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authKey** | **String**|  | 
 **userId** | **String**|  | 
 **contactUserId** | **String**|  | 
 **body** | [**Body**](Body.md)|  | [optional] 

### Return type

[**InlineResponse2004**](InlineResponse2004.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

