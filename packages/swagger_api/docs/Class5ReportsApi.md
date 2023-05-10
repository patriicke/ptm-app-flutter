# swagger.api.Class5ReportsApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://ptameetings.com/service/*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createNewReport**](Class5ReportsApi.md#createNewReport) | **POST** /reports | 
[**editReport**](Class5ReportsApi.md#editReport) | **PUT** /reports/report | 
[**getReportDetail**](Class5ReportsApi.md#getReportDetail) | **GET** /reports/report | 
[**getReportList**](Class5ReportsApi.md#getReportList) | **GET** /reports | 
[**rateReport**](Class5ReportsApi.md#rateReport) | **PUT** /reports/rating | 
[**studentsGet**](Class5ReportsApi.md#studentsGet) | **GET** /students | 


# **createNewReport**
> InlineResponse20010 createNewReport(authKey, body)



Create a new report

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class5ReportsApi();
var authKey = authKey_example; // String | Authentication key for the user
var body = new CreateEditReportVm(); // CreateEditReportVm | 

try { 
    var result = api_instance.createNewReport(authKey, body);
    print(result);
} catch (e) {
    print("Exception when calling Class5ReportsApi->createNewReport: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authKey** | **String**| Authentication key for the user | 
 **body** | [**CreateEditReportVm**](CreateEditReportVm.md)|  | 

### Return type

[**InlineResponse20010**](InlineResponse20010.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **editReport**
> InlineResponse20010 editReport(authKey, reportId, body)



Edit an existing report

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class5ReportsApi();
var authKey = authKey_example; // String | Authentication key for the user
var reportId = reportId_example; // String | 
var body = new CreateEditReportVm(); // CreateEditReportVm | 

try { 
    var result = api_instance.editReport(authKey, reportId, body);
    print(result);
} catch (e) {
    print("Exception when calling Class5ReportsApi->editReport: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authKey** | **String**| Authentication key for the user | 
 **reportId** | **String**|  | 
 **body** | [**CreateEditReportVm**](CreateEditReportVm.md)|  | 

### Return type

[**InlineResponse20010**](InlineResponse20010.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReportDetail**
> InlineResponse20010 getReportDetail(authKey, reportId)



Get details of an existing report

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class5ReportsApi();
var authKey = authKey_example; // String | Authentication key for the user
var reportId = reportId_example; // String | 

try { 
    var result = api_instance.getReportDetail(authKey, reportId);
    print(result);
} catch (e) {
    print("Exception when calling Class5ReportsApi->getReportDetail: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authKey** | **String**| Authentication key for the user | 
 **reportId** | **String**|  | 

### Return type

[**InlineResponse20010**](InlineResponse20010.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReportList**
> InlineResponse20011 getReportList(authKey)



Get a list of reports

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class5ReportsApi();
var authKey = authKey_example; // String | Authentication key for the user

try { 
    var result = api_instance.getReportList(authKey);
    print(result);
} catch (e) {
    print("Exception when calling Class5ReportsApi->getReportList: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authKey** | **String**| Authentication key for the user | 

### Return type

[**InlineResponse20011**](InlineResponse20011.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rateReport**
> InlineResponse20010 rateReport(authKey, reportId, body)



Function for parents to leave a comment on an existing report

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class5ReportsApi();
var authKey = authKey_example; // String | Authentication key for the user
var reportId = reportId_example; // String | Id of the report to leave comment on
var body = new ReportParentCommentVm(); // ReportParentCommentVm | Rating details

try { 
    var result = api_instance.rateReport(authKey, reportId, body);
    print(result);
} catch (e) {
    print("Exception when calling Class5ReportsApi->rateReport: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authKey** | **String**| Authentication key for the user | 
 **reportId** | **String**| Id of the report to leave comment on | 
 **body** | [**ReportParentCommentVm**](ReportParentCommentVm.md)| Rating details | [optional] 

### Return type

[**InlineResponse20010**](InlineResponse20010.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **studentsGet**
> InlineResponse2009 studentsGet(authKey, userName)



Search for a student

### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new Class5ReportsApi();
var authKey = authKey_example; // String | Authentication key for the user
var userName = userName_example; // String | Search query string for student

try { 
    var result = api_instance.studentsGet(authKey, userName);
    print(result);
} catch (e) {
    print("Exception when calling Class5ReportsApi->studentsGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authKey** | **String**| Authentication key for the user | 
 **userName** | **String**| Search query string for student | [optional] 

### Return type

[**InlineResponse2009**](InlineResponse2009.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

