import 'package:drop_here_mobile/notifications/model/api/notifications_api.dart';
import 'package:drop_here_mobile/notifications/services/executive_service/notification_executive_service.dart';
import 'package:drop_here_mobile/notifications/services/observer_service/notification_observer_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//todo usee
class LocalNotificationExecutiveService extends NotificationExecutiveService {
  static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  @override
  Future<String> fetchToken() {
    // TODO: implement fetchToken
    throw UnimplementedError();
  }

  @override
  BroadcastingServiceType getServiceType() {
    // TODO: implement getServiceType
    throw UnimplementedError();
  }

  @override
  Future<void> init(NotifyObservers notifyObservers) {
    // TODO: implement init
    throw UnimplementedError();
  }

  // //todo macias gdzies indziej to wyrzucic - bo to bedzie globalne a nie firebasowe
  // void initState() {
  //   var initializationSettingsAndroid =
  //   new AndroidInitializationSettings('@mipmap/ic_launcher');
  //   var initializationSettingsIOS = new IOSInitializationSettings();
  //   var initializationSettings = new InitializationSettings(
  //       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  //
  //   flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  //   flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //       onSelectNotification: onSelectNotification);
  // }
  //
  // //todo macias 2
  // Future<dynamic> onSelectNotification(String payload) async {
  //   //Do whatever you want to do on notification click. In this case, I'll show an alert dialog*/ /*
  //   print("klikł");
  // }
  //
  // //todo macias 3
  // static Future<void> showNotification(
  //     int notificationId,
  //     String notificationTitle,
  //     String notificationContent,
  //     String payload, {
  //       String channelId = '1234',
  //       String channelTitle = 'Android Channel',
  //       String channelDescription = 'Default Android Channel for notifications',
  //       Priority notificationPriority = Priority.high,
  //       Importance notificationImportance = Importance.max,
  //     }) async {
  //   var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
  //       channelId, channelTitle, channelDescription,
  //       playSound: false,
  //       importance: notificationImportance,
  //       priority: notificationPriority);
  //   var iOSPlatformChannelSpecifics =
  //   new IOSNotificationDetails(presentSound: false);
  //   var platformChannelSpecifics = new NotificationDetails(
  //       android: androidPlatformChannelSpecifics,
  //       iOS: iOSPlatformChannelSpecifics);
  //
  //   await flutterLocalNotificationsPlugin.show(
  //     notificationId,
  //     notificationTitle,
  //     notificationContent,
  //     platformChannelSpecifics,
  //     payload: payload,
  //   );
  // }
}