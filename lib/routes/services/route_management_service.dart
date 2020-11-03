import 'dart:convert';

import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:drop_here_mobile/routes/model/route_request_api.dart';
import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:get/get.dart';

class RouteManagementService {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();

  Future<String> getCompanyId() async {
    dynamic response = await _httpClient.get(
        canRepeatRequest: true, path: "/management/companies", out: (dynamic json) => json);
    Company companyInfo = Company.fromJson(response);
    return companyInfo.uid;
  }

  Future<ResourceOperationResponse> createRoute(UnpreparedRouteRequest routeRequest) async {
    String companyId = await getCompanyId();
    dynamic response = await _httpClient.post(
        canRepeatRequest: true,
        path: "/companies/$companyId/routes",
        body: json.encode(routeRequest.toJson()),
        out: (dynamic json) => json);
    return ResourceOperationResponse.fromJson(response);
  }

  Future<RoutePage> fetchRoutes() async {
    String companyId = await getCompanyId();
    dynamic response = await _httpClient.get(
        canRepeatRequest: true, path: "/companies/$companyId/routes", out: (dynamic json) => json);
    return RoutePage.fromJson(response);
  }

  Future<ResourceOperationResponse> deleteRoute(String routeId) async {
    String companyId = await getCompanyId();
    dynamic response = await _httpClient.delete(
        canRepeatRequest: true,
        path: "/companies/$companyId/routes/$routeId",
        out: (dynamic json) => json);
    return ResourceOperationResponse.fromJson(response);
  }
}
