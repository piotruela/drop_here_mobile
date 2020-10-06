import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/customer_management_api.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:get/get.dart';

class CustomerManagementApi {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();

  Future<CustomerInfoResponse> getCustomerInfo() async {
    dynamic response = await _httpClient.get(
        canRepeatRequest: true, path: "/management/customers", out: (dynamic json) => json);
    return CustomerInfoResponse.fromJson(response);
  }

  Future<ResourceOperationResponse> updateCustomerInfo(
      CustomerManagementRequest customerManagementRequest) async {
    dynamic response = await _httpClient.post(
        canRepeatRequest: true,
        path: "/management/customers",
        body: json.encode(customerManagementRequest.toJson()),
        out: (dynamic json) => json);
    return ResourceOperationResponse.fromJson(response);
  }

  Future<ResourceOperationResponse> uploadCustomerPhoto(File file) async {
    try {
      Dio dio = new Dio();
      dio.options.headers[HttpHeaders.authorizationHeader] = _httpClient.token;
      MultipartFile multipartFile = await MultipartFile.fromFile(file.path);
      FormData formData = FormData.fromMap({"image": multipartFile});
      Response response = await dio
          .post("https://drop-here.herokuapp.com/management/customers/images", data: formData);
      return ResourceOperationResponse.fromJson(response.data);
    } catch (error) {
      return ResourceOperationResponse()..operationStatus = OperationStatus.ERROR;
    }
  }
}
