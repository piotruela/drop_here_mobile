import 'package:json_annotation/json_annotation.dart';

part 'notification_observer_service.g.dart';

enum NotificationType { CLICKED_APP_TERMINATED, CLICKED_APP_BACKGROUND, CLICKED_VIEW_NOT_DEFINED, HIDDEN_APP_FOREGROUND }

enum ReferencedSubjectType { EMPTY, DROP, SPOT, SHIPMENT, UNKNOWN }

@JsonSerializable()
class NotificationPayload {
  String title;
  String message;
  ReferencedSubjectType referencedSubjectType;
  String referencedSubjectId;
  NotificationType notificationType;

  NotificationPayload(this.title, this.message, this.referencedSubjectType, this.referencedSubjectId, this.notificationType);

  factory NotificationPayload.fromJson(Map<String, dynamic> json) => _$NotificationPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationPayloadToJson(this);
}

abstract class NotificationObserver {
  Future<void> handleNotification(NotificationPayload payload);
}

typedef NotifyObservers = Future<void> Function(NotificationPayload notificationPayload);
