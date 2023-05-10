import 'dart:developer';

import 'package:swagger_api/swagger_api.dart';

class MeetingsRepository {
  Future<List<Meeting>> getMeetings(String authKey) async {
    var meetingApi = MeetingApi();

    var response = await meetingApi.getMeetings(authKey);
    if (response.apiResponseMessage.code != 200) {
      log('Exception when calling MeetingApi->teacherUserSignupTellUsMore. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
      throw Exception(
          'Exception when calling MeetingApi->teacherUserSignupTellUsMore. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
    }
    return response.data;
  }

  Future<Meeting> updateMeetingStatus(
      String authKey, String meetingId, String userId, int newStatus) async {
    var meetingApi = MeetingApi();

    var response = await meetingApi.updateMeetingAttendanceStatus(
        meetingId, authKey, userId, newStatus);
    if (response.apiResponseMessage.code != 200) {
      log('Exception when calling MeetingApi->updateMeetingAttendanceStatus. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
      throw Exception(
          'Exception when calling MeetingApi->updateMeetingAttendanceStatus. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
    }
    return response.data;
  }

  Future<Meeting> createNewMeeting(String authKey, CreateMeetingVm vm) async {
    var meetingApi = MeetingApi();

    var response = await meetingApi.createNewMeeting(authKey, vm);
    if (response.apiResponseMessage.code != 200) {
      log('Exception when calling MeetingApi->createNewMeeting. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
      throw Exception(
          'Exception when calling MeetingApi->createNewMeeting. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
    }
    return response.data;
  }

  Future<Meeting> registerMeetingEntry(
      String authKey, String meetingId, String userId, String enteredOn) async {
    var meetingApi = MeetingApi();

    var vm = RegisterMeetingEntryVm();
    vm.enteredOn = enteredOn;
    vm.userId = userId;

    var response = await meetingApi.registerMeetingEntry(
      meetingId,
      authKey,
    );
    if (response.apiResponseMessage.code != 200) {
      log('Exception when calling MeetingApi->registerMeetingEntry. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
      throw Exception(
          'Exception when calling MeetingApi->registerMeetingEntry. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
    }
    return response.data;
  }

  Future<List<Meeting>> getEnteredMeetings(String authKey) async {
    var meetingApi = MeetingApi();

    var response = await meetingApi.meetingsAttendedPhpGet(authKey);

    if (response.apiResponseMessage.code != 200) {
      log('Exception when calling MeetingApi->meetingsAttendedGet. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
      throw Exception(
          'Exception when calling MeetingApi->meetingsAttendedGet. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
    }
    return response.data;
  }
}
