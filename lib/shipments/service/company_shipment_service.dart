import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:drop_here_mobile/shipments/model/api/company_shipment_request.dart';
import 'package:drop_here_mobile/shipments/model/api/company_shipment_response.dart';
import 'package:get/get.dart';

class CompanyShipmentService {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();
  final CompanyManagementService _companyManagementService = Get.find<CompanyManagementService>();

  Future<CompanyShipmentsPage> getCompanyShipments(CompanyShipmentRequest companyShipmentRequest) async {
    String companyId = await _companyManagementService.getCompanyId();
    dynamic response = await _httpClient.get(
        canRepeatRequest: true,
        path: "/companies/$companyId/shipments?${companyShipmentRequest?.toQueryParams() ?? ''}",
        out: (dynamic json) => json);
    return CompanyShipmentsPage.fromJson(response);
  }

  Future<ShipmentResponse> getCompanyShipment(String shipmentId) async {
    String companyId = await _companyManagementService.getCompanyId();
    dynamic response = await _httpClient.get(
        canRepeatRequest: true, path: "/companies/$companyId/shipments/$shipmentId", out: (dynamic json) => json);
    return ShipmentResponse.fromJson(response);
  }

  Future<ResourceOperationResponse> updateShipmentStatus(
      ShipmentCompanyDecisionRequest shipmentCompanyDecisionRequest, String shipmentId) async {
    String companyId = await _companyManagementService.getCompanyId();
    dynamic response = await _httpClient.patch(
        canRepeatRequest: true, path: "/companies/$companyId/shipments/$shipmentId", out: (dynamic json) => json);
    return ResourceOperationResponse.fromJson(response);
  }
}
