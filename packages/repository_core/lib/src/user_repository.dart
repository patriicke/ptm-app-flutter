import 'dart:async';
import 'dart:developer';

import 'package:repository_core/src/models/models.dart';
import 'package:swagger_api/swagger_api.dart';

class UserRepository {
  // Fetches the user by id from repository
  // Persists the retrieved user as the current user in this repository
  // Returns the fetched user as a UserEntity object
  Future<UserEntity> getCurrentUserById(String userId, String authKey) async {
    var userApi = UserApi();

    var response = await userApi.getUserById(userId, authKey);
    if (response.apiResponseMessage.code != 200) {
      log('Exception when calling UserApi->getUserById. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
      throw Exception(
          'Exception when calling UserApi->getUserById. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
    }

    var user = UserEntity.fromApiUser(response.data);
    return user;
  }

  // Calls registerParentChildren from UserApi.
  // Passes userId from _currentUser.id to the function
  Future<void> registerParentChildren(
      String userId, String authKey, List<ParentChild> children) async {
    var userApi = UserApi();
    try {
      await userApi.registerParentChildren(userId, authKey, children);
    } catch (e) {
      print('Exception when calling UserApi->registerParentChildren: $e\n');
      throw Exception(
          'Exception when calling UserApi->registerParentChildren: $e\n');
    }
  }

  Future<List<UserSearchResultDto>> searchTeachers(
      String authKey, String query) async {
    var userApi = UserApi();
    var teachers =
        await userApi.searchUsers(authKey, userType: 1, userName: query);
    var code = teachers.apiResponseMessage.code;
    if (code == 400 || code == 401) {
      print(
          'Exception when calling UserApi->searchUsers: ${teachers.apiResponseMessage.message}\n');
      throw Exception(teachers.apiResponseMessage.message);
    }
    return teachers.data;
  }

  Future<List<UserSearchResultDto>> searchParents(
      String authKey, String query) async {
    var userApi = UserApi();
    try {
      var teachers =
          await userApi.searchUsers(authKey, userType: 0, userName: query);
      var code = teachers.apiResponseMessage.code;
      if (code == 400 || code == 401) {
        print(
            'Exception when calling UserApi->searchUsers: ${teachers.apiResponseMessage.message}\n');
        throw Exception(teachers.apiResponseMessage.message);
      }
      return teachers.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> registerParentTeacherConnections(String userId, String authKey,
      List<ParentTeacherConnectionDto> connections) async {
    var userApi = UserApi();
    try {
      var response = await userApi.registerParentTeacherConnections(
          userId, authKey, connections);
      if (response.code != 200) {
        log('Exception when calling UserApi->registerParentTeacherConnections. code: ${response.code}, message: ${response.message}\n');
        throw Exception(
            'Exception when calling UserApi->registerParentTeacherConnections. code: ${response.code}, message: ${response.message}\n');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> completeUserProfile(
      String userId, String authKey, ProfileCompletionVm vm) async {
    var userApi = UserApi();
    var response = await userApi.completeUserSignup(userId, authKey, vm);
    if (response.code != 200) {
      log('Exception when calling UserApi->completeUserSignup. code: ${response.code}, message: ${response.message}\n');
      throw Exception(
          'Exception when calling UserApi->completeUserSignup. code: ${response.code}, message: ${response.message}\n');
    }
  }

  Future<void> tellUsMore(
      String userId, String authKey, TeacherTellUsMoreVm vm) async {
    var userApi = UserApi();
    var response =
        await userApi.teacherUserSignupTellUsMore(userId, authKey, vm);
    if (response.code != 200) {
      log('Exception when calling UserApi->teacherUserSignupTellUsMore. code: ${response.code}, message: ${response.message}\n');
      throw Exception(
          'Exception when calling UserApi->teacherUserSignupTellUsMore. code: ${response.code}, message: ${response.message}\n');
    }
  }
}
