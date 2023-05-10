import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meetings/blocs/authentication/authentication_bloc.dart';
import 'package:meetings/blocs/login_type/login_type_bloc.dart';
import 'package:meetings/consts.dart';
import 'package:meetings/home/bloc/meetings_home/meetings_home_bloc.dart';
import 'package:meetings/landing/bloc/app_tab_bloc.dart';
import 'package:meetings/landing/screen/landing_screen.dart';
import 'package:meetings/screens/splash_screen.dart';
import 'package:meetings/screens/login_type_selection.dart';
import 'package:meetings/signup/screen/child_info_screen.dart';
import 'package:meetings/signup/screen/connect_teachers_screen.dart';
import 'package:meetings/signup/screen/profile_completion_screen.dart';
import 'package:meetings/signup/screen/tell_us_more_screen.dart';
import 'package:meetings/signup/screen/verification_screen.dart';
import 'package:repository_core/repository_core.dart';


class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.userRepository,
    @required this.meetingsRepository,
    @required this.chatRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        assert(meetingsRepository != null),
        assert(chatRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final MeetingsRepository meetingsRepository;
  final ChatRepository chatRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider.value(value: userRepository),
        RepositoryProvider.value(value: meetingsRepository),
        RepositoryProvider.value(value: chatRepository),
      ],
      child: MultiBlocProvider(
        child: AppView(),
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
              userRepository: userRepository,
            ),
          ),
          BlocProvider<LoginTypeBloc>(
            create: (BuildContext context) => LoginTypeBloc(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider<MeetingsHomeBloc>(
            create: (context) => MeetingsHomeBloc(
              authenticationRepository: authenticationRepository,
              meetingsRepository: meetingsRepository,
            ),
          ),
          BlocProvider<AppTabBloc>(
            create: (context) => AppTabBloc(),
          ),
        ],
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  FirebaseMessaging messaging;

  void translateAuthenticatedUserRoute(UserStatus userStatus) {
    switch (userStatus) {
      case UserStatus.parentSignedUp:
        _navigator.pushAndRemoveUntil<void>(
            ChildInfoScreen.route(), (route) => false);
        break;
      case UserStatus.parentChildrenSubmitted:
        _navigator.pushAndRemoveUntil<void>(
            ConnectTeachersScreen.route(), (route) => false);
        break;
      case UserStatus.parentTeachersConnected:
        _navigator.pushAndRemoveUntil<void>(
            ProfileCompletionScreen.route(), (route) => false);
        break;
      case UserStatus.parentProfileCompleted:
        _navigator.pushAndRemoveUntil<void>(
          LandingScreenNew.route(),
              (route) => false,
        );
        break;
      case UserStatus.teacherSignedUp:
        _navigator.pushAndRemoveUntil<void>(
            TellUsMoreScreen.route(), (route) => false);
        break;
      case UserStatus.teacherInfoSubmitted:
        _navigator.pushAndRemoveUntil<void>(
            ProfileCompletionScreen.route(), (route) => false);
        break;
      case UserStatus.teacherProfileCompleted:
        _navigator.pushAndRemoveUntil<void>(
          LandingScreenNew.route(),
              (route) => false,
        );
        break;
      case UserStatus.blocked:
        break;
      case UserStatus.parentVerifying:
        _navigator.pushAndRemoveUntil<void>(
          VerificationScreen.route(),
              (route) => false,
        );
        break;
      case UserStatus.teacherVerifying:
        _navigator.pushAndRemoveUntil<void>(
          VerificationScreen.route(),
              (route) => false,
        );
        break;
      case UserStatus.profileUpdated:
        _navigator.pushAndRemoveUntil<void>(
          LandingScreenNew.route(),
              (route) => false,
        );
        break;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value){
      print("token--$value");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
    enableIOSNotifications();
    registerNotificationListeners();
  }

  registerNotificationListeners() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSSettings = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    var initSetttings =
    InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: (message) async {
          // This function handles the click in the notification when the app is in foreground
          // Get.toNamed(NOTIFICATIOINS_ROUTE);
        });
// onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Get.find<HomeController>().getNotificationsNumber();
      print(message);
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              icon: android.smallIcon,
              playSound: true,
            ),
          ),
        );
      }
    });
  }

  enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  androidNotificationChannel() => AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications',
    'This channel is used for important notifications.',
    importance: Importance.max,
    playSound: true,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return new Theme(
          data: new ThemeData(
            primaryColor: PrimaryColor,
            primaryColorDark: AccentColor,
            accentColor: AccentColor,
            hintColor: AccentColor,
            tabBarTheme: TabBarTheme(
              labelColor: PrimaryColor,
            ),
            inputDecorationTheme: new InputDecorationTheme(
              border: new OutlineInputBorder(
                borderSide: new BorderSide(
                  color: AccentColor,
                ),
                borderRadius: new BorderRadius.circular(10.0),
              ),
              enabledBorder: new OutlineInputBorder(
                borderSide: new BorderSide(
                  color: AccentColor,
                ),
                borderRadius: new BorderRadius.circular(10.0),
              ),
            ),
          ),
          child: MultiBlocListener(
            listeners: [
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  switch (state.status) {
                    case AuthenticationStatus.verifying:
                      _navigator.pushAndRemoveUntil<void>(
                        VerificationScreen.route(),
                        (route) => false,
                      );
                      break;
                    case AuthenticationStatus.authenticated:
                      translateAuthenticatedUserRoute(
                          RepositoryProvider.of<AuthenticationRepository>(
                                  context)
                              .currentUser
                              .status);
                      break;
                    case AuthenticationStatus.unauthenticated:
                      _navigator.pushAndRemoveUntil<void>(
                        LoginTypeSelectionScreen.route(),
                        (route) => false,
                      );
                      break;
                    default:
                      break;
                  }
                },
              ),
            ],
            child: child,
          ),
        );
      },
      onGenerateRoute: (_) => SplashScreen.route(),
    );
  }
}
