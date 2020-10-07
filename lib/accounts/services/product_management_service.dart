import 'dart:convert';
import 'dart:io';

import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/company_products_request.dart';
import 'package:drop_here_mobile/accounts/model/api/page_api.dart';
import 'package:drop_here_mobile/accounts/model/api/product_management_api.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:get/get.dart';

class ProductManagementService {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();
  final Map<String, String> _headers = {HttpHeaders.contentTypeHeader: "application/json"};
  final CompanyManagementService _companyManagementService = Get.find<CompanyManagementService>();

  Future<ProductsPage> getCompanyProducts([CompanyProductsRequest companyProductsRequest]) async {
    String companyId = await _companyManagementService.getCompanyId();
    dynamic response = await _httpClient.get(
        canRepeatRequest: true,
        path: "/companies/$companyId/products${companyProductsRequest?.toQueryParams() ?? ''}",
        out: (dynamic json) => json);
    return ProductsPage.fromJson(response);
  }

  Future<List<ProductCategoryResponse>> getCategories() async {
    String companyId = await _companyManagementService.getCompanyId();
    List<dynamic> response = await _httpClient.get(
        canRepeatRequest: true,
        path: "/companies/$companyId/categories",
        out: (dynamic json) => json);
    List<ProductCategoryResponse> categories = [];
    for (dynamic element in response) {
      categories.add(ProductCategoryResponse.fromJson(element));
    }
    return categories;
  }

  Future<ResourceOperationResponse> addProduct(
      ProductManagementRequest productManagementRequest) async {
    String companyId = await _companyManagementService.getCompanyId();
    dynamic response = await _httpClient.post(
        headers: _headers,
        body: json.encode(productManagementRequest.toJson()),
        canRepeatRequest: true,
        path: "/companies/$companyId/products",
        out: (dynamic json) => json);

    return ResourceOperationResponse.fromJson(response);
  }

  Future<List<ProductUnitResponse>> getUnits() async {
    List<dynamic> response =
        await _httpClient.get(canRepeatRequest: true, path: "/units", out: (dynamic json) => json);
    List<ProductUnitResponse> units = [];
    for (dynamic element in response) {
      units.add(ProductUnitResponse.fromJson(element));
    }
    return units;
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
