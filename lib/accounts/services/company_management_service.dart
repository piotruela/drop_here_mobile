import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drop_here_mobile/accounts/model/api/company_customers_request.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/page_api.dart';
import 'package:drop_here_mobile/accounts/model/client.dart';
import 'package:drop_here_mobile/accounts/model/company.dart' as localCompany;
import 'package:drop_here_mobile/accounts/model/seller.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:get/get.dart';

class CompanyManagementService {
  final Map<String, String> _headers = {HttpHeaders.contentTypeHeader: "application/json"};
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();

  CompanyManagementService();

  Future<Company> getCompanyInfo() async {
    dynamic response = await _httpClient.get(
        canRepeatRequest: true, path: "/management/companies", out: (dynamic json) => json);
    return Company.fromJson(response);
  }

  Future<localCompany.Company> getFakeCompanyInfo() async {
    return Future.delayed(Duration(milliseconds: 500), () {
      return localCompany.Company(
          name: 'Yellow company',
          country: 'Yomenia',
          isVisible: true,
          isRegistered: true,
          numberOfSellers: 123);
    });
  }

  Future<String> getCompanyId() async {
    dynamic response = await _httpClient.get(
        canRepeatRequest: true, path: "/management/companies", out: (dynamic json) => json);
    Company companyInfo = Company.fromJson(response);
    return companyInfo.uid;
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

  Future<Page> getCompanyCustomers(CompanyCustomersRequest companyCustomersRequest) async {
    dynamic response = await _httpClient.get(
        canRepeatRequest: true,
        path: "/management/companies/customers?${companyCustomersRequest.toQueryParams()}",
        out: (dynamic json) => json);
    return Page.fromJson(response);
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

  Future<List<Client>> fetchClientsList({String filter, String searchText}) {
    //TODO implement
    List<Client> clients = [
      Client(name: 'abc', isActive: true, numberOfDropsMember: 5),
      Client(name: 'def', isActive: false, numberOfDropsMember: 3)
    ];
    return Future.delayed(Duration(seconds: 1), () {
      return clients;
    });
  }

  Future<List<Seller>> fetchSellersList({String filter, String searchText}) {
    //TODO implement
    List<Seller> sellers = [
      Seller(name: 'john', isActive: true, surname: 'snow'),
      Seller(name: 'bart', isActive: false, surname: 'simpson')
    ];
    return Future.delayed(Duration(seconds: 1), () {
      return sellers;
    });
  }
}
