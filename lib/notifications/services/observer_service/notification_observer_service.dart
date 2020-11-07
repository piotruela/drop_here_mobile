enum NotificationType { CLICKED_APP_TERMINATED, CLICKED_APP_BACKGROUND, HIDDEN_APP_FOREGROUND }

enum ReferencedSubjectType { EMPTY, DROP, SPOT, SHIPMENT }

class NotificationPayload {
  final String title;
  final String message;
  final ReferencedSubjectType referencedSubjectType;
  final String referencedSubjectId;
  final NotificationType notificationType;

  NotificationPayload(this.title, this.message, this.referencedSubjectType,
      this.referencedSubjectId, this.notificationType);
}

abstract class NotificationObserver {
  Future<void> handleNotification(NotificationPayload payload);
}

typedef NotifyObservers = Future<void> Function(
    NotificationPayload notificationPayload);
