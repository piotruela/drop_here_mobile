import 'dart:convert';
import 'dart:io';

import 'package:drop_here_mobile/accounts/model/company/company_register_details_api.dart';
import 'package:drop_here_mobile/accounts/model/credentials.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:get/get.dart';

class RegistrationService {
  final Map<String, String> _headers = {HttpHeaders.contentTypeHeader: "application/json"};
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();

  RegistrationService();

  Future<RegistrationResult> register(RegistrationCredentials registrationCredentials) async {
    try {
      Map<String, dynamic> response = await _httpClient.post(
          canRepeatRequest: true,
          headers: _headers,
          body: json.encode(registrationCredentials.toJson()),
          path: "/accounts",
          out: (_) => (_));
      print(response['token']);
      _httpClient.setHttpHeader(HttpHeaders.authorizationHeader, "Bearer ${response['token']}");
      return RegistrationResult.account_created;
    } catch (error) {
      if (error is HttpStatusException) {
        switch (error.statusCode) {
          case 422:
            return RegistrationResult.account_exists;
            break;
          case 400:
            return RegistrationResult.bad_credentials;
            break;
          default:
            return RegistrationResult.error;
            break;
        }
      }
      return RegistrationResult.error;
    }
  }

  Future<int> updateCompanyDetails(CompanyDetails companyDetails) async {
    try {
      dynamic response = await _httpClient.put(
          canRepeatRequest: true,
          headers: _headers,
          body: json.encode(companyDetails.toJson()),
          path: "management/companies",
          out: (dynamic json) => json);
      print(response.toString());
      return 1;
    } catch (error) {
      return -1;
    }
  }
}

enum RegistrationResult { account_created, account_exists, bad_credentials, error, in_progress }
