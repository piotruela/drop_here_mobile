import 'dart:convert';

import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:drop_here_mobile/routes/model/route_request_api.dart';
import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:get/get.dart';

class RouteManagementService {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();
  final CompanyManagementService _companyManagementService = Get.find<CompanyManagementService>();

  Future<ResourceOperationResponse> createRoute(UnpreparedRouteRequest routeRequest) async {
    String companyId = await _companyManagementService.getCompanyId();
    dynamic response = await _httpClient.post(
        canRepeatRequest: true,
        path: "/companies/$companyId/routes",
        body: json.encode(routeRequest.toJson()),
        out: (dynamic json) => json);
    return ResourceOperationResponse.fromJson(response);
  }

  Future<RoutePage> fetchRoutes() async {
    String companyId = await _companyManagementService.getCompanyId();
    dynamic response = await _httpClient.get(
        canRepeatRequest: true, path: "/companies/$companyId/routes", out: (dynamic json) => json);
    return RoutePage.fromJson(response);
  }

  Future<ResourceOperationResponse> deleteRoute(String routeId) async {
    String companyId = await _companyManagementService.getCompanyId();
    dynamic response = await _httpClient.delete(
        canRepeatRequest: true, path: "/companies/$companyId/routes/$routeId", out: (dynamic json) => json);
    return ResourceOperationResponse.fromJson(response);
  }

  Future<RouteResponse> fetchRoute(int routeId) async {
    String companyId = await _companyManagementService.getCompanyId();
    dynamic response = await _httpClient.get(
        canRepeatRequest: true, path: "/companies/$companyId/routes/$routeId", out: (dynamic json) => json);
    return RouteResponse.fromJson(response);
  }

  Future<ResourceOperationResponse> updateRoute(UnpreparedRouteRequest routeRequest, int routeId) async {
    String companyId = await _companyManagementService.getCompanyId();
    dynamic response = await _httpClient.put(
        canRepeatRequest: true,
        path: "/companies/$companyId/routes/$routeId",
        body: json.encode(routeRequest.toJson()),
        out: (dynamic json) => json);
    return ResourceOperationResponse.fromJson(response);
  }

  Future<ResourceOperationResponse> updateRouteStatus(int routeId, RouteStatus status) async {
    String companyId = await _companyManagementService.getCompanyId();
    RouteStateChangeRequest request = RouteStateChangeRequest(newStatus: status);
    dynamic response = await _httpClient.patch(
        canRepeatRequest: true,
        path: "/companies/$companyId/routes/$routeId",
        body: json.encode(request.toJson()),
        out: (dynamic json) => json);
    return ResourceOperationResponse.fromJson(response);
  }

  Future<ResourceOperationResponse> updateDropStatus(String dropUid, DropStatus status, int delayDuration) async {
    DropManagementRequest request =
        DropManagementRequest(newStatus: status, delayByMinutes: status == DropStatus.DELAYED ? delayDuration : null);
    dynamic response = await _httpClient.put(
        canRepeatRequest: true,
        path: "/management/companies/drops/$dropUid",
        body: json.encode(request.toJson()),
        out: (dynamic json) => json);
    return ResourceOperationResponse.fromJson(response);
  }
}
