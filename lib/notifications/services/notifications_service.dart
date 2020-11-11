import 'dart:convert';

import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:drop_here_mobile/notifications/model/api/notifications_api.dart';
import 'package:get/get.dart';

class NotificationsService {
  Future<void> updateToken(NotificationTokenManagementRequest notificationTokenManagementRequest) async {
    final DhHttpClient _httpClient = Get.find<DhHttpClient>();

    return await _httpClient.put(
        canRepeatRequest: true,
        path: "/notifications/tokens",
        body: json.encode(notificationTokenManagementRequest.toJson()),
        out: (dynamic json) => json);
  }
}
