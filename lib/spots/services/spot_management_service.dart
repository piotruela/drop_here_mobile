import 'dart:convert';

import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:get/get.dart';

class SpotManagementService {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();
  final CompanyManagementService _companyManagementService = Get.find<CompanyManagementService>();

  Future<SpotCompanyResponse> fetchSpotDetails(String spotUid) async {
    dynamic response = await _httpClient.get(
        canRepeatRequest: true, path: "/spots/$spotUid", out: (dynamic json) => json);
    return SpotCompanyResponse.fromJson(response);
  }

  Future<ResourceOperationResponse> addSpot(SpotManagementRequest spotManagementRequest) async {
    String companyId = await _companyManagementService.getCompanyId();
    dynamic response = await _httpClient.post(
        body: json.encode(spotManagementRequest.toJson()),
        canRepeatRequest: true,
        path: "/companies/$companyId/spots",
        out: (dynamic json) => json);

    return ResourceOperationResponse.fromJson(response);
  }

  Future<ResourceOperationResponse> updateSpot(
      SpotManagementRequest spotManagementRequest, String spotId) async {
    String companyId = await _companyManagementService.getCompanyId();
    dynamic response = await _httpClient.put(
        body: json.encode(spotManagementRequest.toJson()),
        canRepeatRequest: true,
        path: "/companies/$companyId/spots/$spotId",
        out: (dynamic json) => json);

    return ResourceOperationResponse.fromJson(response);
  }

  Future<ResourceOperationResponse> deleteSpot(int spotId) async {
    String companyId = await _companyManagementService.getCompanyId();
    dynamic response = await _httpClient.delete(
        canRepeatRequest: true,
        path: "/companies/$companyId/spots/$spotId",
        out: (dynamic json) => json);

    return ResourceOperationResponse.fromJson(response);
  }

  Future<List<SpotCompanyResponse>> fetchCompanySpots() async {
    String companyId = await _companyManagementService.getCompanyId();
    List<dynamic> response = await _httpClient.get(
        canRepeatRequest: true, path: "/companies/$companyId/spots", out: (dynamic json) => json);
    List<SpotCompanyResponse> spots = [];
    for (dynamic element in response) {
      spots.add(SpotCompanyResponse.fromJson(element));
    }
    return spots;
  }
}
