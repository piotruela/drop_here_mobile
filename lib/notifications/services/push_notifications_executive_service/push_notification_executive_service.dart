import 'package:drop_here_mobile/notifications/model/api/notifications_api.dart';

abstract class PushNotificationsExecutiveService {
  BroadcastingServiceType getServiceType();

  Future<String> fetchToken();

  Future<void> init();
}
