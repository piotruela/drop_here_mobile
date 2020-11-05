import 'package:drop_here_mobile/notifications/model/api/notifications_api.dart';
import 'package:drop_here_mobile/notifications/services/push_notifications_executive_service/push_notification_executive_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebasePushNotificationsExecutiveService
    extends PushNotificationsExecutiveService {
  static FirebaseMessaging _fcm = FirebaseMessaging();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  Future<String> fetchToken() async {
    return await _fcm.getToken();
  }

  @override
  BroadcastingServiceType getServiceType() {
    return BroadcastingServiceType.FIREBASE;
  }

  @override
  Future<void> init() async {
    _fcm.requestNotificationPermissions(IosNotificationSettings());
    initState();
    return _configure();
  }

  static Future<void> _configure() async {
    return await _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          _onMessage(message);
        },
        onLaunch: (Map<String, dynamic> message) async {
          _onLaunch(message);
        },
        onResume: (Map<String, dynamic> message) async {
          _onResume(message);
        },
        onBackgroundMessage: myBackgroundMessageHandler);
  }

  //todo na backencdzie wysylac click_action FLUTTER_NOTIFICATION_CLICK
  static void _onResume(Map<String, dynamic> message) {
    print("onResume: $message");
    // TODO optional
  }

  static void _onLaunch(Map<String, dynamic> message) {
    print("onLaunch: $message");
    // TODO optional
  }

//todo
  static void _onMessage(Map<String, dynamic> message) async{
    print("onMessage: $message");
    await showNotification(
        1234,
        "GET title FROM message OBJECT",
        "GET description FROM message OBJECT",
        "GET PAYLOAD FROM message OBJECT");
  }

  //todo macias gdzies indziej to wyrzucic
  void initState() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  //todo macias 2
  Future<dynamic> onSelectNotification(String payload) async {
    //Do whatever you want to do on notification click. In this case, I'll show an alert dialog*/ /*
    print("klikł");
  }

  //todo macias 3
  static Future<void> showNotification(
    int notificationId,
    String notificationTitle,
    String notificationContent,
    String payload, {
    String channelId = '1234',
    String channelTitle = 'Android Channel',
    String channelDescription = 'Default Android Channel for notifications',
    Priority notificationPriority = Priority.high,
    Importance notificationImportance = Importance.max,
  }) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      channelId,
      channelTitle,
      channelDescription,
      playSound: false,
      importance: notificationImportance,
      priority: notificationPriority,
    );
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      notificationId,
      notificationTitle,
      notificationContent,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }
}
