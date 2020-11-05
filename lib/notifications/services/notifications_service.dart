import 'dart:convert';

import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:drop_here_mobile/notifications/model/api/notifications_api.dart';
import 'package:get/get.dart';

class NotificationsService {
  Future<ResourceOperationResponse> updateToken(
      NotificationTokenManagementRequest
          notificationTokenManagementRequest) async {
    final DhHttpClient _httpClient = Get.find<DhHttpClient>();

    dynamic response = await _httpClient.put(
        canRepeatRequest: true,
        path: "/notifications/tokens",
        body: json.encode(notificationTokenManagementRequest.toJson()),
        out: (dynamic json) => json);

    return ResourceOperationResponse.fromJson(response);
  }
}
