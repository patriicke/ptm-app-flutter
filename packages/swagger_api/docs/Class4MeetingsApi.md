# swagger.api.Class4MeetingsApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://ptameetings.com/service/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createNewMeeting**](Class4MeetingsApi.md#createNewMeeting) | **POST** /meetings | 
[**getMeetings**](Class4MeetingsApi.md#getMeetings) | **GET** /meetings | 
[**registerMeetingEntry**](Class4MeetingsApi.md#registerMeetingEntry) | **PUT** /meetings/registerEntry | 
[**updateMeetingAttendanceStatus**](Class4MeetingsApi.md#updateMeetingAttendanceStatus) | **PUT** /meetings/updateAttendanceStatus | 


# **createNewMeeting**
> InlineResponse20019 createNewMeeting(authKey, body)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class4MeetingsApi();
var authKey = authKey_example; // String | Authentication key for the user
var body = new CreateMeetingVm(); // CreateMeetingVm | 

try { 
    var result = api_instance.createNewMeeting(authKey, body);
    print(result);
} catch (e) {
    print("Exception when calling Class4MeetingsApi->createNewMeeting: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authKey** | **String**| Authentication key for the user | 
 **body** | [**CreateMeetingVm**](CreateMeetingVm.md)|  | 

### Return type

[**InlineResponse20019**](InlineResponse20019.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMeetings**
> InlineResponse20018 getMeetings(authKey)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class4MeetingsApi();
var authKey = authKey_example; // String | Authentication key for the user

try { 
    var result = api_instance.getMeetings(authKey);
    print(result);
} catch (e) {
    print("Exception when calling Class4MeetingsApi->getMeetings: $e\n");
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

# **registerMeetingEntry**
> InlineResponse20019 registerMeetingEntry(meetingId, authKey, body)



Log event for user entering a meeting

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class4MeetingsApi();
var meetingId = meetingId_example; // String | 
var authKey = authKey_example; // String | Authentication key for the user
var body = new RegisterMeetingEntryVm(); // RegisterMeetingEntryVm | 

try { 
    var result = api_instance.registerMeetingEntry(meetingId, authKey, body);
    print(result);
} catch (e) {
    print("Exception when calling Class4MeetingsApi->registerMeetingEntry: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **meetingId** | **String**|  | 
 **authKey** | **String**| Authentication key for the user | 
 **body** | [**RegisterMeetingEntryVm**](RegisterMeetingEntryVm.md)|  | [optional] 

### Return type

[**InlineResponse20019**](InlineResponse20019.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMeetingAttendanceStatus**
> InlineResponse20020 updateMeetingAttendanceStatus(meetingId, authKey, body)



This endpoint is called by UI when users Accept or Reject a meeting.

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class4MeetingsApi();
var meetingId = meetingId_example; // String | The Id of the meeting that the user wants to change attendance status
var authKey = authKey_example; // String | Authentication key for the user
var body = new UpdateMeetingStatusVm(); // UpdateMeetingStatusVm | The Id of the user who's attendance status will change

try { 
    var result = api_instance.updateMeetingAttendanceStatus(meetingId, authKey, body);
    print(result);
} catch (e) {
    print("Exception when calling Class4MeetingsApi->updateMeetingAttendanceStatus: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **meetingId** | **String**| The Id of the meeting that the user wants to change attendance status | 
 **authKey** | **String**| Authentication key for the user | 
 **body** | [**UpdateMeetingStatusVm**](UpdateMeetingStatusVm.md)| The Id of the user who&#39;s attendance status will change | 

### Return type

[**InlineResponse20020**](InlineResponse20020.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

