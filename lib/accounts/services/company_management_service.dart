import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:get/get.dart';
//TODO: Get clients list
/*curl -X GET "https://drop-here.herokuapp.com/management/companies/customers?blocked=true
&customerName=dd&offset=12&pageNumber=12&pageSize=12&paged=true&sort.sorted=false
&sort.unsorted=true&unpaged=true" */

class CompanyManagementService {
  final Map<String, String> _headers = {HttpHeaders.contentTypeHeader: "application/json"};
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();

  CompanyManagementService();

  Future<Company> getCompanyInfo() async {
    dynamic response = await _httpClient.get(
        canRepeatRequest: true, path: "/management/companies", out: (dynamic json) => json);
    return Company.fromJson(response);
  }

  Future<int> updateCompanyDetails(CompanyManagementRequest companyDetails) async {
    try {
      dynamic response = await _httpClient.put(
          canRepeatRequest: true,
          headers: _headers,
          body: json.encode(companyDetails.toJson()),
          path: "/management/companies",
          out: (dynamic json) => json);
      print(response.toString());
      return 1;
    } catch (error) {
      return -1;
    }
  }

  Future<ResourceOperationResponse> uploadCompanyPhoto(File file) async {
    try {
      Dio dio = new Dio();
      dio.options.headers[HttpHeaders.authorizationHeader] = _httpClient.token;
      MultipartFile multipartFile = await MultipartFile.fromFile(file.path);
      FormData formData = FormData.fromMap({"image": multipartFile});
      Response response = await dio
          .post("https://drop-here.herokuapp.com/management/companies/images", data: formData);
      return ResourceOperationResponse.fromJson(response.data);
    } catch (error) {
      return ResourceOperationResponse()..operationStatus = OperationStatus.ERROR;
    }
  }
}
