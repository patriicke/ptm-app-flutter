import 'dart:async';
import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:repository_core/src/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swagger_api/swagger_api.dart';

enum AuthenticationStatus { unknown, verifying, authenticated, unauthenticated }
enum LoginType { unspecified, parent, teacher }

class AuthenticationRepository {
  final _statusController = StreamController<AuthenticationStatus>();
  final _authKeyController = StreamController<String>();
  String _authKey;
  LoginType _loginType = LoginType.unspecified;
  final _loginTypeController = StreamController<LoginType>();
  final _currentUserController = StreamController<UserEntity>();
  UserEntity _currentUser;
  UserEntity get currentUser => _currentUser;
  String _signupEventId;

  Stream<UserEntity> get currentUserStream async* {
    yield null;
    yield* _currentUserController.stream;
  }

  Stream<AuthenticationStatus> get status async* {
    var prefs = await SharedPreferences.getInstance();
    // await Future<void>.delayed(const Duration(milliseconds: 5));
    final prefsAuthKey = prefs.getString('authKey');
    final prefsLoginType = prefs.getString('loginType');
    final prefsUserId = prefs.getString('currentUserId');
    final prefsUserStatus = prefs.getString('currentUserStatus');
    if (prefsAuthKey != null &&
        prefsLoginType != null &&
        prefsUserId != null &&
        prefsUserStatus != null &&
        prefsAuthKey != '' &&
        prefsLoginType != '' &&
        prefsUserId != '' &&
        prefsUserStatus != '') {
      _authKey = prefsAuthKey;
      if (prefsLoginType == 'parent') {
        _loginType = LoginType.parent;
      } else if (prefsLoginType == 'teacher') {
        _loginType = LoginType.teacher;
      } else {
        _loginType = LoginType.unspecified;
      }
      _loginTypeController.add(_loginType);
      var userStatus = UserEntity.statusFromString(prefsUserStatus);
      _currentUser = UserEntity(
        id: prefsUserId,
        status: userStatus,
        userStatusString: prefsUserStatus,
      );
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _statusController.stream;
  }

  Stream<String> get authKeyStream async* {
    yield* _authKeyController.stream;
  }

  String get authKey {
    return _authKey;
  }

  LoginType get loginType {
    return _loginType;
  }

  Stream<LoginType> get loginTypeStream async* {
    yield LoginType.unspecified;
    yield* _loginTypeController.stream;
  }

  Future<void> updateLoginType(LoginType newType) async {
    _loginType = newType;
    var prefs = await SharedPreferences.getInstance();
    var loginTypeString =
        _loginType.toString().substring(_loginType.toString().indexOf('.') + 1);
    await prefs.setString('loginType', loginTypeString);
    _loginTypeController.add(newType);
  }

  Future<void> updateUserStatus(UserStatus newStatus) async {
    var userStatusString =
        newStatus.toString().substring(newStatus.toString().indexOf('.') + 1);
    _currentUser = _currentUser.copyWith(
      status: newStatus,
      userStatusString: userStatusString,
    );

    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentUserStatus', _currentUser.userStatusString);
  }

  Future<void> updateAuthKey(String newAuthKey) async {
    _authKey = newAuthKey;
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('authKey', _authKey);
  }

  Future<User> signupUser(
      String username,
      String email,
      String password,
      String phone,
      String about,
      int userType,
      ) async {
    var user_api = UserApi();
    var newUserData = UserSignupVm();
    newUserData.username = username;
    newUserData.email = email;
    newUserData.password = password;
    newUserData.phone = phone;
    newUserData.about = about;
    newUserData.userType = userType;
    try {
      var response = await user_api.addUser(newUserData);

      if (response.apiResponseMessage.code == 405) {
        print(
            'Exception when calling UserApi->addUser: ${response.apiResponseMessage.message}');
        throw Exception(response.apiResponseMessage.message);
      }

      _signupEventId = response.data.signupEventId;
      _currentUser = UserEntity.fromApiUser(response.data.user);

      var prefs = await SharedPreferences.getInstance();

      await prefs.setString('authKey', response.data.user.authKey);
      await prefs.setString('currentUserId', _currentUser.id);
      await prefs.setString('currentUserStatus', _currentUser.userStatusString);
      var loginTypeString = _loginType
          .toString()
          .substring(_loginType.toString().indexOf('.') + 1);
      await prefs.setString('loginType', loginTypeString);

      _statusController.add(AuthenticationStatus.verifying);

      return response.data.user;
    } catch (e) {
      throw Exception(e);
    }
  }

  // Submits email and password to api endpoint and expects userId and authKey in return
  // Persists returned authKey in this repository
  // Returns the userId from api response
  Future<String> logIn({
    String email,
    String password,
  }) async {
    assert(email != null);
    assert(password != null);

    var userApi = UserApi();

    var loginResponse = await userApi.loginUser(email, password);
    var code = loginResponse.apiResponseMessage.code;
    if (code == 400 || code == 409) {
      print(
          'Exception when calling UserApi->loginUser: ${loginResponse.apiResponseMessage.message}');
      throw Exception(loginResponse.apiResponseMessage.message);
    }

    try {
      userApi = UserApi();
      var userResponse = await userApi.getUserById(
          loginResponse.data.userId, loginResponse.data.authKey);
      _currentUser = UserEntity.fromApiUser(userResponse.data);
    } catch (e) {
      rethrow;
    }

    _authKey = loginResponse.data.authKey;

    var prefs = await SharedPreferences.getInstance();

    await prefs.setString('authKey', _authKey);
    await prefs.setString('currentUserId', _currentUser.id);
    await prefs.setString('currentUserStatus', _currentUser.userStatusString);
    var loginTypeString =
        _loginType.toString().substring(_loginType.toString().indexOf('.') + 1);
    await prefs.setString('loginType', loginTypeString);

    _authKeyController.add(loginResponse.data.authKey);
    _statusController.add(AuthenticationStatus.authenticated);
    return loginResponse.data.userId;
  }

  Future<void> verifyAccount({String oneTimePasscode}) async {
    var user_api = UserApi();

    var response = await user_api.verifyUserSignup(
        _currentUser.id, _signupEventId, oneTimePasscode);
    if (response.apiResponseMessage.code == 400) {
      print(
          'Exception when calling UserApi->verifyUserSignup: ${response.apiResponseMessage.message}');
      throw Exception(response.apiResponseMessage.message);
    }

    _authKey = response.data.authKey;
    _currentUser = UserEntity.fromApiUser(response.data.userInfo);

    var prefs = await SharedPreferences.getInstance();

    await prefs.setString('authKey', _authKey);
    await prefs.setString('currentUserId', _currentUser.id);
    await prefs.setString('currentUserStatus', _currentUser.userStatusString);
    var loginTypeString =
        _loginType.toString().substring(_loginType.toString().indexOf('.') + 1);
    await prefs.setString('loginType', loginTypeString);

    _authKeyController.add(response.data.authKey);
    _signupEventId = null;
    _statusController.add(AuthenticationStatus.authenticated);
  }

  Future<void> logOut() async {
    _currentUser = null;
    _authKey = null;
    _loginType = LoginType.unspecified;

    var prefs = await SharedPreferences.getInstance();

    await prefs.setString('authKey', '');
    await prefs.setString('currentUserId', '');
    await prefs.setString('currentUserStatus', '');
    await prefs.setString('loginType', '');

    _currentUserController.add(null);
    _authKeyController.add(null);
    _statusController.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() {
    _statusController.close();
    _authKeyController.close();
    _loginTypeController.close();
  }
}
