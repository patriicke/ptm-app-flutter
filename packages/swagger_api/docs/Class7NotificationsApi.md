# swagger.api.Class7NotificationsApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://ptameetings.com/service/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getUserNotifications**](Class7NotificationsApi.md#getUserNotifications) | **GET** /notifications | 
[**seeNotification**](Class7NotificationsApi.md#seeNotification) | **PUT** /notifications | 


# **getUserNotifications**
> InlineResponse2006 getUserNotifications(notificationFilter, authKey, userId)



Fetch a list of the user's notifications

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class7NotificationsApi();
var notificationFilter = notificationFilter_example; // String | 
var authKey = authKey_example; // String | 
var userId = userId_example; // String | Id of the user for who the notifications will be fetched

try { 
    var result = api_instance.getUserNotifications(notificationFilter, authKey, userId);
    print(result);
} catch (e) {
    print("Exception when calling Class7NotificationsApi->getUserNotifications: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **notificationFilter** | **String**|  | 
 **authKey** | **String**|  | 
 **userId** | **String**| Id of the user for who the notifications will be fetched | 

### Return type

[**InlineResponse2006**](InlineResponse2006.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **seeNotification**
> InlineResponse2007 seeNotification(authKey, notificationId)



Record a notification's 'seen' status

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class7NotificationsApi();
var authKey = authKey_example; // String | 
var notificationId = notificationId_example; // String | 

try { 
    var result = api_instance.seeNotification(authKey, notificationId);
    print(result);
} catch (e) {
    print("Exception when calling Class7NotificationsApi->seeNotification: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authKey** | **String**|  | 
 **notificationId** | **String**|  | 

### Return type

[**InlineResponse2007**](InlineResponse2007.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

