import 'package:drop_here_mobile/notifications/model/api/notifications_api.dart';
import 'package:drop_here_mobile/notifications/services/observer_service/notification_observer_service.dart';

abstract class NotificationExecutiveService {
  BroadcastingServiceType getServiceType();

  bool requiresToken();

  Future<String> fetchToken();

  Future<void> init(NotifyObservers notifyObserversFunction);
}
