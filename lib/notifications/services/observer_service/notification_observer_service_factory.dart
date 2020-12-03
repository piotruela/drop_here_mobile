import 'package:get/get.dart';

import 'local_notification_push_notification_observer.dart';
import 'navigating_click_observer.dart';
import 'notification_observer_service.dart';

class NotificationObserverFactory {
  final List<NotificationObserver> _notificationObservers = [
    Get.find<LocalNotificationPopOutObserver>(),
    Get.find<NavigatingClickObserver>()
  ];

  List<NotificationObserver> getNotificationObservers() {
    return _notificationObservers;
  }
}
