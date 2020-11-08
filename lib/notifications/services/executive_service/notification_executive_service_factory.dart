import 'package:drop_here_mobile/notifications/services/executive_service/local_notification_executive_service.dart';
import 'package:drop_here_mobile/notifications/services/executive_service/notification_executive_service.dart';
import 'package:get/get.dart';

import 'firebase_push_notifications_executive_service.dart';

class NotificationExecutiveServiceFactory {
  final List<NotificationExecutiveService> _notificationExecutiveServices = [
    Get.find<FirebasePushNotificationsExecutiveService>(),
    Get.find<LocalNotificationExecutiveService>()
  ];

  List<NotificationExecutiveService> getPushNotificationsExecutiveServices() {
    return _notificationExecutiveServices;
  }
}
