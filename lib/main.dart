import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:meetings/app.dart';
import 'package:repository_core/repository_core.dart';

import 'FCM/firebase_options.dart';
import 'notifications/notificationservice/local_notification_service.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('background message ${message.notification.body}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  await Firebase.initializeApp(
      name: 'parent-teacher-meet',
      options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  //await PushNotificationService().setupInteractedMessage();

  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
    meetingsRepository: MeetingsRepository(),
    chatRepository: ChatRepository(),
  ));
}
