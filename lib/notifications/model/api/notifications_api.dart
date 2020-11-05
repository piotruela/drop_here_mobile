import 'package:json_annotation/json_annotation.dart';

part 'notifications_api.g.dart';

enum BroadcastingServiceType { FIREBASE }

@JsonSerializable()
class NotificationTokenManagementRequest {
  BroadcastingServiceType broadcastingServiceType;
  String token;

  NotificationTokenManagementRequest(
      {this.broadcastingServiceType, this.token});

  factory NotificationTokenManagementRequest.fromJson(
          Map<String, dynamic> json) =>
      _$NotificationTokenManagementRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$NotificationTokenManagementRequestToJson(this);
}
