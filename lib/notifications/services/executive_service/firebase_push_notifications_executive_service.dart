import 'package:drop_here_mobile/notifications/model/api/notifications_api.dart';
import 'package:drop_here_mobile/notifications/services/executive_service/notification_executive_service.dart';
import 'package:drop_here_mobile/notifications/services/observer_service/notification_observer_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebasePushNotificationsExecutiveService
    extends NotificationExecutiveService {
  static FirebaseMessaging _fcm = FirebaseMessaging();
  final String _fcmNotificationKey = 'notification';
  final String _fcmNotificationTitle = 'title';
  final String _fcmNotificationBody = 'body';
  final String _fcmDataKey = 'data';
  final String _fcmDataNotificationReferencedSubjectType =
      'DROP_HERE_NOTIFICATION_REFERENCED_SUBJECT_TYPE';
  final String _fcmDataNotificationReferencedSubjectId =
      'DROP_HERE_NOTIFICATION_REFERENCED_SUBJECT_ID';

  NotifyObservers _notifyObserversFunction;

  @override
  Future<String> fetchToken() async {
    return await _fcm.getToken();
  }

  @override
  BroadcastingServiceType getServiceType() {
    return BroadcastingServiceType.FIREBASE;
  }

  @override
  Future<void> init(NotifyObservers notifyObserversFunction) {
    _notifyObserversFunction = notifyObserversFunction;
    _fcm.requestNotificationPermissions(IosNotificationSettings());
    return _configure();
  }

  Future<void> _configure() async {
    return _fcm.configure(onMessage: (Map<String, dynamic> message) async {
      _onMessage(message);
    }, onLaunch: (Map<String, dynamic> message) async {
      _onLaunch(message);
    }, onResume: (Map<String, dynamic> message) async {
      _onResume(message);
    });
  }

  Future<void> _onResume(Map<String, dynamic> message) async {
    var notificationPayload = _toNotificationPayload(
        message, NotificationType.CLICKED_APP_BACKGROUND);
    _notifyObserversFunction.call(notificationPayload);
  }

  Future<void> _onLaunch(Map<String, dynamic> message) async {
    var notificationPayload = _toNotificationPayload(
        message, NotificationType.CLICKED_APP_TERMINATED);
    _notifyObserversFunction.call(notificationPayload);
  }

  void _onMessage(Map<String, dynamic> message) async {
    var notificationPayload =
        _toNotificationPayload(message, NotificationType.HIDDEN_APP_FOREGROUND);
    _notifyObserversFunction.call(notificationPayload);
  }

  NotificationPayload _toNotificationPayload(
      Map<String, dynamic> message, NotificationType type) {
    return new NotificationPayload(
        message[_fcmNotificationKey][_fcmNotificationTitle],
        message[_fcmNotificationKey][_fcmNotificationBody],
        _getReferencedSubjectType(
            message[_fcmDataKey][_fcmDataNotificationReferencedSubjectType]),
        message[_fcmDataKey][_fcmDataNotificationReferencedSubjectId],
        type);
  }

  @override
  bool requiresToken() {
    return true;
  }

  ReferencedSubjectType _getReferencedSubjectType(referencedSubjectType) {
    return ReferencedSubjectType.values.firstWhere(
        (element) => element.toString().split(".").last == referencedSubjectType,
        orElse: () => ReferencedSubjectType.UNKNOWN);
  }
}
