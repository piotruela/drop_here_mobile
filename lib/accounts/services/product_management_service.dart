import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/company_products_request.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:get/get.dart';

class ProductManagementService {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();
  final CompanyManagementService _companyManagementService = Get.find<CompanyManagementService>();

  Future<dynamic> getCompanyProducts([CompanyProductsRequest companyProductsRequest]) async {
    String companyId = await _companyManagementService.getCompanyId();
    print("/companies/$companyId/products${companyProductsRequest?.toQueryParams() ?? ''}");
    dynamic response = await _httpClient.get(
        canRepeatRequest: true,
        path: "/companies/$companyId/products${companyProductsRequest?.toQueryParams() ?? ''}",
        out: (dynamic json) => json);
    return response;
    //TODO: Map response to ProductApiModel
  }

  Future<ResourceOperationResponse> deleteProduct(String productId) async {
    String companyId = await _companyManagementService.getCompanyId();
    dynamic response = await _httpClient.delete(
        canRepeatRequest: true,
        path: "/companies/$companyId/products/$productId",
        out: (dynamic json) => json);
    return ResourceOperationResponse.fromJson(response);
  }
}
