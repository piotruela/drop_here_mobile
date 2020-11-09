import 'package:drop_here_mobile/notifications/services/executive_service/local_notification_executive_service.dart';
import 'package:drop_here_mobile/notifications/services/observer_service/notification_observer_service.dart';
import 'package:get/get.dart';

class LocalNotificationPopOutObserver extends NotificationObserver {
  final LocalNotificationExecutiveService _localNotificationService =
      Get.find<LocalNotificationExecutiveService>();

  @override
  Future<void> handleNotification(NotificationPayload payload) {
    if (payload.notificationType == NotificationType.HIDDEN_APP_FOREGROUND) {
      return _localNotificationService.createNotification(payload);
    }
    return Future.value();
  }
}
