import 'dart:convert';

import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:drop_here_mobile/shipments/model/api/company_shipment_response.dart';
import 'package:drop_here_mobile/shipments/model/api/customer_shipment_request.dart';
import 'package:get/get.dart';

class CustomerShipmentService {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();

  Future<ResourceOperationResponse> createShipment(
      String companyUid, String dropUid, ShipmentCustomerSubmissionRequest request) async {
    dynamic response = await _httpClient.post(
        canRepeatRequest: true,
        body: json.encode(request.toJson()),
        path: "/companies/$companyUid/drops/$dropUid/shipments",
        out: (dynamic json) => json);
    return ResourceOperationResponse.fromJson(response);
  }

  Future<ResourceOperationResponse> updateShipment(
      String companyUid, String dropUid, String shipmentId, ShipmentCustomerSubmissionRequest request) async {
    dynamic response = await _httpClient.put(
        canRepeatRequest: true,
        body: json.encode(request.toJson()),
        path: "/companies/$companyUid/drops/$dropUid/shipments/$shipmentId",
        out: (dynamic json) => json);
    return ResourceOperationResponse.fromJson(response);
  }

  Future<ResourceOperationResponse> updateShipmentStatus(
      String companyUid, String dropUid, String shipmentId, ShipmentCustomerDecisionRequest request) async {
    dynamic response = await _httpClient.patch(
        canRepeatRequest: true,
        body: json.encode(request.toJson()),
        path: "/companies/$companyUid/drops/$dropUid/shipments/$shipmentId",
        out: (dynamic json) => json);
    return ResourceOperationResponse.fromJson(response);
  }

  Future<ShipmentsPage> getShipments(CustomerShipmentRequest request) async {
    dynamic response = await _httpClient.get(
        canRepeatRequest: true, path: "/shipments?${request.toQueryParams()}", out: (dynamic json) => json);
    return ShipmentsPage.fromJson(response);
  }

  Future<ShipmentResponse> getShipment(String shipmentId) async {
    dynamic response =
        await _httpClient.get(canRepeatRequest: true, path: "/shipments/$shipmentId", out: (dynamic json) => json);
    return ShipmentResponse.fromJson(response);
  }
}
