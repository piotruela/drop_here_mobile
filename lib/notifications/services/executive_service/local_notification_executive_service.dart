import 'dart:convert';

import 'package:drop_here_mobile/notifications/model/api/notifications_api.dart';
import 'package:drop_here_mobile/notifications/services/executive_service/notification_executive_service.dart';
import 'package:drop_here_mobile/notifications/services/observer_service/notification_observer_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationExecutiveService extends NotificationExecutiveService {
  NotifyObservers _notifyObserversFunction;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  final NotificationDetails _platformChannelSpecifics = new NotificationDetails(
      android: new AndroidNotificationDetails(
          'LocalNotificationsChannel1', 'LocalNotificationsChannel', 'Local notifications channel',
          playSound: true, importance: Importance.max, priority: Priority.high),
      iOS: new IOSNotificationDetails(presentSound: true));

  @override
  bool requiresToken() {
    return false;
  }

  @override
  Future<String> fetchToken() {
    //Not needed to implement since requiresToken() == false
    return Future.value();
  }

  @override
  BroadcastingServiceType getServiceType() {
    return BroadcastingServiceType.LOCAL_NOTIFICATIONS;
  }

  @override
  Future<void> init(NotifyObservers notifyObserversFunction) {
    this._notifyObserversFunction = notifyObserversFunction;

    var initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/app_logo');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    return _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future<void> createNotification(NotificationPayload notificationPayload) {
    return _flutterLocalNotificationsPlugin.show(
      1,
      notificationPayload.title,
      notificationPayload.message,
      _platformChannelSpecifics,
      payload: json.encode(notificationPayload.toJson()),
    );
  }

  Future<dynamic> onSelectNotification(String payload) async {
    var previousNotification = NotificationPayload.fromJson(jsonDecode(payload));
    previousNotification.notificationType = NotificationType.CLICKED_VIEW_NOT_DEFINED;
    _notifyObserversFunction.call(previousNotification);
  }
}
