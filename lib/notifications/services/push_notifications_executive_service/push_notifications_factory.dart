import 'package:drop_here_mobile/notifications/model/api/notifications_api.dart';
import 'package:drop_here_mobile/notifications/services/push_notifications_executive_service/push_notification_executive_service.dart';
import 'package:get/get.dart';

import 'firebase_push_notifications_executive_service.dart';

class PushNotificationsExecutiveServiceFactory {
  final FirebasePushNotificationsExecutiveService _firebase =
      Get.find<FirebasePushNotificationsExecutiveService>();

  final BroadcastingServiceType _currentPushNotificationsImplementation =
      BroadcastingServiceType.FIREBASE;

  PushNotificationsExecutiveService getPushNotificationsExecutiveService() {
    if (_currentPushNotificationsImplementation ==
        BroadcastingServiceType.FIREBASE) {
      return _firebase;
    }
    throw UnsupportedError(
        "Invalid push notifications executive service implementation");
  }
}
