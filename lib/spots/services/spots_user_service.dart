import 'dart:convert';

import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:drop_here_mobile/spots/model/api/spot_user_api.dart';
import 'package:get/get.dart';

class SpotsUserService {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();

  Future<List<SpotBaseCustomerResponse>> getSpots(SpotCustomerRequest spotCustomerRequest) async {
    List<dynamic> response = await _httpClient.get(
        canRepeatRequest: true,
        path: "/spots?${spotCustomerRequest?.toQueryParams() ?? ''}",
        out: (dynamic json) => json);
    return response.map((element) => SpotBaseCustomerResponse.fromJson(element)).toList();
  }

  Future<SpotDetailedCustomerResponse> getSpotDetails(String spotUid) async {
    dynamic response =
        await _httpClient.get(canRepeatRequest: true, path: "/spots/$spotUid", out: (dynamic json) => json);
    return SpotDetailedCustomerResponse.fromJson(response);
  }

  Future<ResourceOperationResponse> joinSpot(String spotUid, String companyUid, SpotJoinRequest spotJoinRequest) async {
    try {
      return await _httpClient.post(
          body: json.encode(spotJoinRequest.toJson()),
          canRepeatRequest: true,
          path: "/spots/$spotUid/companies/$companyUid/memberships",
          out: (dynamic response) => ResourceOperationResponse.fromJson(response));
    } on HttpStatusException {
      return ResourceOperationResponse()..operationStatus = OperationStatus.ERROR;
    }
  }

  Future<ResourceOperationResponse> updateSpotSettings(
      String spotUid, String companyUid, SpotMembershipManagementRequest managementRequest) async {
    try {
      return await _httpClient.put(
          body: json.encode(managementRequest.toJson()),
          canRepeatRequest: true,
          path: "/spots/$spotUid/companies/$companyUid/memberships",
          out: (dynamic response) => ResourceOperationResponse.fromJson(response));
    } on HttpStatusException {
      return ResourceOperationResponse()..operationStatus = OperationStatus.ERROR;
    }
  }

  Future<ResourceOperationResponse> leavingSpot(String spotUid, String companyUid) async {
    try {
      return await _httpClient.delete(
          canRepeatRequest: true,
          path: "/spots/$spotUid/companies/$companyUid/memberships",
          out: (dynamic response) => ResourceOperationResponse.fromJson(response));
    } on HttpStatusException {
      return ResourceOperationResponse()..operationStatus = OperationStatus.ERROR;
    }
  }
}
