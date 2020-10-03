import 'dart:convert';
import 'dart:io';

import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/authentication_api.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:get/get.dart';

class AccountService {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();

  Future<int> createProfile(AccountProfileCreationRequest form) async {
    try {
      dynamic response = await _httpClient.post(
          canRepeatRequest: true,
          body: json.encode(form.toJson()),
          path: "/accounts/profiles",
          out: (dynamic json) => json);
      print(response['token']);
      _httpClient.setHttpHeader(HttpHeaders.authorizationHeader, "Bearer ${response['token']}");
      return 1;
    } catch (Error) {
      return -1;
    }
  }

  Future<AccountInfoResponse> fetchAccountDetails() async {
    dynamic response = await _httpClient.get(
        canRepeatRequest: true, path: "/accounts", out: (dynamic json) => json);
    return AccountInfoResponse.fromJson(response);
  }

  Future<List<ProfileInfoResponse>> fetchProfiles() async {
    dynamic response = await _httpClient.get(
        canRepeatRequest: true, path: "/accounts", out: (dynamic json) => json);
    AccountInfoResponse account = AccountInfoResponse.fromJson(response);
    return account.profiles;
  }

  Future<LoginResponse> register(AccountCreationRequest accountCreationRequest) async {
    try {
      Map<String, dynamic> response = await _httpClient.post(
          canRepeatRequest: true,
          body: json.encode(accountCreationRequest.toJson()),
          path: "/accounts",
          out: (_) => (_));
      print(response['token']);
      _httpClient.setHttpHeader(HttpHeaders.authorizationHeader, "Bearer ${response['token']}");
      return LoginResponse.fromJson(response);
    } catch (error) {
      return LoginResponse()..token = '-1';
    }
  }
}
