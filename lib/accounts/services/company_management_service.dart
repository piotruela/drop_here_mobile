import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/company_customers_request.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/model/seller.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:drop_here_mobile/products/model/api/page_api.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:flutter/material.dart' hide Page;
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

  Future<List<ProfileInfoResponse>> fetchCompanySellers() async {
    dynamic response = await _httpClient.get(
        canRepeatRequest: true, path: "/accounts", out: (dynamic json) => json);
    AccountInfoResponse account = AccountInfoResponse.fromJson(response);
    return account.profiles;
  }

  void uploadCompanyPhoto(Future<File> file) async {
    try {
      File loadedFile = await file;
      Dio dio = new Dio();
      dio.options.headers[HttpHeaders.authorizationHeader] = _httpClient.token;
      MultipartFile multipartFile = await MultipartFile.fromFile(loadedFile.path);
      FormData formData = FormData.fromMap({"image": multipartFile});
      await dio.post("https://drop-here.herokuapp.com/management/companies/images", data: formData);
      return;
    } catch (error) {
      return;
    }
  }

  Future<Image> getCompanyPhoto() async {
    String companyId = await getCompanyId();
    return Image.network(
      "https://drop-here.herokuapp.com/companies/$companyId/images",
      headers: {"authorization": "${_httpClient.token}"},
      errorBuilder: (context, _, __) => FittedBox(
          child: CircleAvatar(
              backgroundColor: Colors.white, child: Icon(Icons.person, color: Colors.black))),
    );
  }

  Future<List<Seller>> fetchSellersList({String filter, String searchText}) {
    //TODO implement
    List<Seller> sellers = [
      Seller(name: 'jon', isActive: true, surname: 'snow'),
      Seller(name: 'bart', isActive: false, surname: 'simpson')
    ];
    return Future.delayed(Duration(seconds: 1), () {
      return sellers;
    });
  }

  Future<List<Product>> fetchProductsList({String filter, String searchText}) {
    //TODO implement
    Product product = Product();
    product.name = 'Apple';
    product.category = 'Fruits';
    product.description = 'descdkfldsfk sdjflskd jfl;skdfj ';
    product.unit = 'kilograms';
    product.price = 6;
    product.unitFraction = 0.5;
    List<Product> products = [product];
    return Future.delayed(Duration(seconds: 1), () {
      return products;
    });
  }
}
