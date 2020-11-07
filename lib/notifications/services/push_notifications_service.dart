import 'package:drop_here_mobile/notifications/model/api/notifications_api.dart';
import 'package:drop_here_mobile/notifications/services/executive_service/notifications_executive_service_factory.dart';
import 'package:drop_here_mobile/notifications/services/notifications_service.dart';
import 'package:drop_here_mobile/notifications/services/observer_service/local_notification_push_notification_observer.dart';
import 'package:drop_here_mobile/notifications/services/observer_service/notification_observer_service.dart';
import 'package:get/get.dart';

class PushNotificationsConfigurationService {
  final PushNotificationsExecutiveServiceFactory _factory =
      Get.find<PushNotificationsExecutiveServiceFactory>();
  final NotificationsService _notificationsService =
      Get.find<NotificationsService>();

  final List<NotificationObserver> _pushNotificationObservers = [
    Get.find<LocalNotificationObserver>()
  ];

  //todo use
  //todo ogarnac inicjkalizacje podczas startu apki
  Future<void> configurePushNotifications() {
    final executiveService = _factory.getPushNotificationsExecutiveService();
    return executiveService
        .init(_observersNotificator)
        .then((value) => executiveService.fetchToken())
        .asStream()
        .map((token) => new NotificationTokenManagementRequest(
            broadcastingServiceType: executiveService.getServiceType(),
            token: token))
        .map((notificationTokenManagementRequest) => _notificationsService
            .updateToken(notificationTokenManagementRequest))
        .drain();
  }

  Future<void> _observersNotificator(NotificationPayload payload) async {
    var map = _pushNotificationObservers
        .map((element) async => {await element.handleNotification(payload)});
    return Future.wait(map);
  }
}
