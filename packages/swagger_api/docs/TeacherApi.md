# swagger.api.TeacherApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://ptameetings.com/service/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getTeacherAvailability**](TeacherApi.md#getTeacherAvailability) | **GET** /teacher/availability | 
[**setTeacherAvailability**](TeacherApi.md#setTeacherAvailability) | **POST** /teacher/availability | 


# **getTeacherAvailability**
> InlineResponse2008 getTeacherAvailability(authKey, userId, availabilityType)



Get list of teacher's availability

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new TeacherApi();
var authKey = authKey_example; // String | Authentication key for the user
var userId = userId_example; // String | 
var availabilityType = availabilityType_example; // String | Filter for type of availability to fetch

try { 
    var result = api_instance.getTeacherAvailability(authKey, userId, availabilityType);
    print(result);
} catch (e) {
    print("Exception when calling TeacherApi->getTeacherAvailability: $e\n");
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

# **setTeacherAvailability**
> InlineResponse2008 setTeacherAvailability(authKey, userId, body)



Set teacher's availability for a given date

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new TeacherApi();
var authKey = authKey_example; // String | Authentication key for the user
var userId = userId_example; // String | 
var body = new SetTeacherAvailabilityVm(); // SetTeacherAvailabilityVm | 

try { 
    var result = api_instance.setTeacherAvailability(authKey, userId, body);
    print(result);
} catch (e) {
    print("Exception when calling TeacherApi->setTeacherAvailability: $e\n");
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

