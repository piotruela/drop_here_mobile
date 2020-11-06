import 'dart:convert';

import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:drop_here_mobile/common/ui/widgets/icon_in_circle.dart';
import 'package:drop_here_mobile/products/model/api/company_products_request.dart';
import 'package:drop_here_mobile/products/model/api/page_api.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductManagementService {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();
  final CompanyManagementService _companyManagementService = Get.find<CompanyManagementService>();

  Future<ProductsPage> getCompanyProducts([CompanyProductsRequest companyProductsRequest]) async {
    String companyId = await _companyManagementService.getCompanyId();
    dynamic response = await _httpClient.get(
        canRepeatRequest: true,
        path: "/companies/$companyId/products${companyProductsRequest?.toQueryParams() ?? ''}",
        out: (dynamic json) => json);
    return ProductsPage.fromJson(response);
  }

  Future<List<String>> getCategories() async {
    String companyId = await _companyManagementService.getCompanyId();
    List<dynamic> response = await _httpClient.get(
        canRepeatRequest: true, path: "/companies/$companyId/categories", out: (dynamic json) => json);

    List<String> categories = [];
    for (dynamic element in response) {
      categories.add(ProductCategoryResponse.fromJson(element).name);
    }
    return categories;
  }

  Future<ResourceOperationResponse> addProduct(ProductManagementRequest productManagementRequest) async {
    String companyId = await _companyManagementService.getCompanyId();
    dynamic response = await _httpClient.post(
        body: json.encode(productManagementRequest.toJson()),
        canRepeatRequest: true,
        path: "/companies/$companyId/products",
        out: (dynamic json) => json);

    return ResourceOperationResponse.fromJson(response);
  }

  Future<List<String>> getUnits() async {
    List<dynamic> response = await _httpClient.get(canRepeatRequest: true, path: "/units", out: (dynamic json) => json);
    List<String> units = [];
    for (dynamic element in response) {
      units.add(ProductUnitResponse.fromJson(element).name);
    }
    return units;
  }

  Future<ResourceOperationResponse> deleteProduct(String productId) async {
    String companyId = await _companyManagementService.getCompanyId();
    dynamic response = await _httpClient.delete(
        canRepeatRequest: true, path: "/companies/$companyId/products/$productId", out: (dynamic json) => json);
    return ResourceOperationResponse.fromJson(response);
  }

  // ignore: missing_return
  Future<ResourceOperationResponse> uploadProductPhoto(Image file, String id) async {
    /*try { TODO:Fix sending photo to server
      String companyId = await _companyManagementService.getCompanyId();
      Dio dio = Dio()..options.headers[HttpHeaders.authorizationHeader] = _httpClient.token;
      dio.options.baseUrl = _httpClient.baseUrl;
      MultipartFile multipartFile = await MultipartFile.fromFile(file.path);
      FormData formData = FormData.fromMap({"image": multipartFile});
      Response response =
          await dio.post("/companies/$companyId/products/$id/images", data: formData);
      return ResourceOperationResponse.fromJson(response.data);
    } catch (error) {
      return ResourceOperationResponse()..operationStatus = OperationStatus.ERROR;
    }*/
  }

  Future<Image> getProductPhoto(String productId) async {
    String companyId = await _companyManagementService.getCompanyId();
    return Image.network("https://drop-here.herokuapp.com/companies/$companyId/products/$productId/images",
        errorBuilder: (context, _, __) => FittedBox(
                child: IconInCircle(
              themeConfig: Get.find<ThemeConfig>(),
              icon: Icons.shopping_basket,
            )));
  }
}
