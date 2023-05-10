# swagger.model.Meeting

## Load the model package
```dart
import 'package:swagger/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | [optional] [default to null]
**title** | **String** |  | [optional] [default to null]
**meetingStartsOn** | [**DateTime**](DateTime.md) |  | [optional] [default to null]
**meetingEndsOn** | [**DateTime**](DateTime.md) |  | [optional] [default to null]
**lastEnteredOn** | [**DateTime**](DateTime.md) | The date and time that the user last attended this meeting. Must be null or empty if not attended before | [optional] [default to null]
**users** | [**List&lt;MeetingUsers&gt;**](MeetingUsers.md) |  | [optional] [default to []]
**meetingRoom** | **String** |  | [optional] [default to null]
**meetingSubject** | **String** |  | [optional] [default to null]
**meetingStatus** | **String** | Determines whether the user is attending the meeting or not | [optional] [default to null]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


