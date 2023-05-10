# swagger.model.NotificationDto

## Load the model package
```dart
import 'package:swagger/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**notificationId** | **String** |  | [optional] [default to null]
**byUserId** | **String** |  | [optional] [default to null]
**byUserName** | **String** |  | [optional] [default to null]
**notifiedOn** | [**DateTime**](DateTime.md) | The exact date and time the notification event took place | [optional] [default to null]
**seen** | **bool** |  | [optional] [default to null]
**meetingId** | **String** | Id of the meeting that this notification is related to. **MUST** be null or empty if not related to meeting. | [optional] [default to null]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


