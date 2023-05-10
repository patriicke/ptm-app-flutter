import 'dart:developer';

import 'package:swagger_api/swagger_api.dart';

class ChatRepository {
  Future<List<ChatContactDto>> getChatContacts(
      String authKey, String userId) async {
    var chatApi = ChatApi();

    var response = await chatApi.getChatContacts(authKey, userId);

    if (response.apiResponseMessage.code != 200) {
      log('Exception when calling ChatApi->getChatContacts. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
      throw Exception(
          'Exception when calling ChatApi->getChatContacts. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
    }
    return response.data;
  }

  Future<InlineResponse20010Data> getChatMessages(
      String authKey, String userId, String contactUserId) async {
    var chatApi = ChatApi();

    var response =
        await chatApi.getChatMessages(authKey, userId, contactUserId);

    if (response.apiResponseMessage.code != 200) {
      log('Exception when calling ChatApi->getChatContacts. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
      throw Exception(
          'Exception when calling ChatApi->getChatContacts. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
    }
    return response.data;
  }

  Future<ChatMessage> sendMessage(String authKey, String userId,
      String contactUserId, String message) async {
    var chatApi = ChatApi();

    var messageBody = Body();
    messageBody.message = message;

    var response = await chatApi.sendMessage(authKey, userId, contactUserId,
        body: messageBody);

    if (response.apiResponseMessage.code != 200) {
      log('Exception when calling ChatApi->sendMessage. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
      throw Exception(
          'Exception when calling ChatApi->sendMessage. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
    }
    return response.data;
  }

  Future<ContactUserDto> getParentContactDetails(
      String authKey, String userId, String contactUserId) async {
    var chatApi = ChatApi();

    var response =
        await chatApi.getParentContactDetails(userId, authKey, contactUserId);

    if (response.apiResponseMessage.code != 200) {
      log('Exception when calling ChatApi->getParentContactDetails. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
      throw Exception(
          'Exception when calling ChatApi->getParentContactDetails. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
    }
    return response.data.parent;
  }

  Future<InlineResponse2007Data> getTeacherContactDetails(
      String authKey, String userId, String contactUserId) async {
    var chatApi = ChatApi();

    var response =
        await chatApi.getTeacherContactDetails(userId, authKey, contactUserId);

    if (response.apiResponseMessage.code != 200) {
      log('Exception when calling ChatApi->getTeacherContactDetails. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
      throw Exception(
          'Exception when calling ChatApi->getTeacherContactDetails. code: ${response.apiResponseMessage.code}, message: ${response.apiResponseMessage.message}\n');
    }
    return response.data;
  }
}
