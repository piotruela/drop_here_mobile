import 'package:drop_here_mobile/notifications/model/api/notifications_api.dart';
import 'package:drop_here_mobile/notifications/services/executive_service/notification_executive_service.dart';
import 'package:drop_here_mobile/notifications/services/executive_service/notification_executive_service_factory.dart';
import 'package:drop_here_mobile/notifications/services/notifications_service.dart';
import 'package:drop_here_mobile/notifications/services/observer_service/notification_observer_service.dart';
import 'package:drop_here_mobile/notifications/services/observer_service/notification_observer_service_factory.dart';
import 'package:get/get.dart';

class NotificationsConfigurationService {
  final NotificationExecutiveServiceFactory _executiveServiceFactory =
      Get.find<NotificationExecutiveServiceFactory>();
  final NotificationObserverFactory _observerFactory = Get.find<NotificationObserverFactory>();
  final NotificationsService _notificationsService = Get.find<NotificationsService>();

  Future<void> configureNotifications() {
    return Future.wait(_executiveServiceFactory
        .getPushNotificationsExecutiveServices()
        .map((executor) async => await _configureNotificationExecutiveService(executor)));
  }

  Future _configureNotificationExecutiveService(NotificationExecutiveService executor) async {
    return await executor
        .init(_observersNotificator)
        .asStream()
        .where((event) => executor.requiresToken())
        .asyncMap((event) => executor.fetchToken())
        .map((token) => new NotificationTokenManagementRequest(
            broadcastingServiceType: executor.getServiceType(), token: token))
        .asyncMap((request) => _notificationsService.updateToken(request))
        .drain()
        .catchError((error) =>
            print('Failed to configure ${executor.runtimeType} ${error.toString()}'));
  }

  Future<void> _observersNotificator(NotificationPayload payload) async {
    return Future.wait(_observerFactory
        .getNotificationObservers()
        .map((observer) async => {await observer.handleNotification(payload)}));
  }
}
