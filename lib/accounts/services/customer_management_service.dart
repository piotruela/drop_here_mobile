import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/customer_management_api.dart';
import 'package:drop_here_mobile/app_storage/app_storage_service.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:get/get.dart' as di;

import 'authentication_service.dart';

class CustomerManagementService {
  final DhHttpClient _httpClient = di.Get.find<DhHttpClient>();
  final AppStorageService _appStorage = di.Get.find<AppStorageService>();
  final AuthenticationService authenticationService = di.Get.find<AuthenticationService>();

  Future<CustomerInfoResponse> getCustomerInfo() async {
    dynamic response =
        await _httpClient.get(canRepeatRequest: true, path: "/management/customers", out: (dynamic json) => json);
    return CustomerInfoResponse.fromJson(response);
  }

  Future<ResourceOperationResponse> updateCustomerInfo(CustomerManagementRequest customerManagementRequest) async {
    dynamic response = await _httpClient.put(
        canRepeatRequest: true,
        path: "/management/customers",
        body: json.encode(customerManagementRequest.toJson()),
        out: (dynamic json) => json);
    return ResourceOperationResponse.fromJson(response);
  }

  Future<ResourceOperationResponse> uploadCustomerPhoto(File file) async {
    try {
      Dio dio = new Dio();
      dio.options.headers[HttpHeaders.authorizationHeader] = _appStorage.authorizationHeader;
      MultipartFile multipartFile = await MultipartFile.fromFile(file.path);
      FormData formData = FormData.fromMap({"image": multipartFile});
      Response response = await dio.post("${_httpClient.baseUrl}/management/customers/images", data: formData);
      return ResourceOperationResponse.fromJson(response.data);
    } catch (error) {
      return ResourceOperationResponse()..operationStatus = OperationStatus.ERROR;
    }
  }

  Future<String> getCustomerPhoto() async {
    CustomerInfoResponse response = await getCustomerInfo();
    String customerId = response.id.toString();
    return "${_httpClient.baseUrl}/customers/$customerId/images";
  }
}
