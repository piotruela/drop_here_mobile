import 'package:drop_here_mobile/notifications/model/api/notifications_api.dart';
import 'package:drop_here_mobile/notifications/services/executive_service/notification_executive_service.dart';
import 'package:get/get.dart';

import 'firebase_push_notifications_executive_service.dart';

//todo macias local
class PushNotificationsExecutiveServiceFactory {
  final FirebasePushNotificationsExecutiveService _firebase =
      Get.find<FirebasePushNotificationsExecutiveService>();

  final BroadcastingServiceType _currentPushNotificationsImplementation =
      BroadcastingServiceType.FIREBASE;

  NotificationExecutiveService getPushNotificationsExecutiveService() {
    if (_currentPushNotificationsImplementation ==
        BroadcastingServiceType.FIREBASE) {
      return _firebase;
    }
    throw UnsupportedError(
        "Invalid push notifications executive service implementation");
  }
}
