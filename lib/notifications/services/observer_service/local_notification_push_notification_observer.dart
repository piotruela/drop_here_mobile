import 'package:drop_here_mobile/notifications/services/observer_service/notification_observer_service.dart';

//todo to chyba inaczej
class LocalNotificationObserver extends NotificationObserver {
  //todo chyba out
  @override
  Future<void> handleNotification(NotificationPayload payload) {
    print('payload $payload');
    // TODO: implement notify
    throw UnimplementedError();
  }
}
