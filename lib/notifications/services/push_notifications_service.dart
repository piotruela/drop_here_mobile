import 'package:drop_here_mobile/notifications/model/api/notifications_api.dart';
import 'package:drop_here_mobile/notifications/services/notifications_service.dart';
import 'package:drop_here_mobile/notifications/services/push_notifications_executive_service/push_notifications_factory.dart';
import 'package:get/get.dart';

class PushNotificationsConfigurationService {
  final PushNotificationsExecutiveServiceFactory _factory =
      Get.find<PushNotificationsExecutiveServiceFactory>();
  final NotificationsService _notificationsService =
      Get.find<NotificationsService>();

  //todo use
  Future<void> configurePushNotifications() {
    final executiveService = _factory.getPushNotificationsExecutiveService();
    return executiveService.init().then((value) =>  executiveService
        .fetchToken())
        .asStream()
        .map((token) => new NotificationTokenManagementRequest(
            broadcastingServiceType: executiveService.getServiceType(),
            token: token))
        .map((notificationTokenManagementRequest) => _notificationsService
            .updateToken(notificationTokenManagementRequest))
        .drain();
  }
}
