import 'dart:convert';
import 'dart:io';

import 'package:drop_here_mobile/accounts/model/api/authentication_api.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:get/get.dart';

class AuthenticationService {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();

  AuthenticationService();

  Future<LoginResponse> authenticationInfo() async {
    dynamic response = await _httpClient.get(
        canRepeatRequest: true, path: "/authentication", out: (dynamic json) => json);
    return LoginResponse.fromJson(response);
  }

  Future<LoginResponse> authenticate(LoginRequest loginRequest) async {
    try {
      Map<String, dynamic> response = await _httpClient.post(
          canRepeatRequest: true,
          body: json.encode(loginRequest.toJson()),
          path: '/authentication',
          out: (_) => (_));
      print(response['token']);
      _httpClient.setHttpHeader(HttpHeaders.authorizationHeader, "Bearer ${response['token']}");
      return LoginResponse.fromJson(response);
    } catch (error) {
      return LoginResponse()..token = '-1';
    }
  }

  void logOutFromAccount() {
    _httpClient.clearHttpHeader("authorization");
    return;
  }

  Future<LoginResponse> logOutFromProfile() async {
    try {
      Map<String, dynamic> response = await _httpClient.delete(
          canRepeatRequest: true, path: '/authentication/profile', out: (dynamic json) => (json));
      print(response['token']);
      _httpClient.setHttpHeader(HttpHeaders.authorizationHeader, "Bearer ${response['token']}");
      return LoginResponse.fromJson(response);
    } catch (error) {
      return LoginResponse()..token = '-1';
    }
  }

  Future<LoginResponse> loginToProfile(ProfileLoginRequest profileLoginRequest) async {
    try {
      Map<String, dynamic> response = await _httpClient.post(
          canRepeatRequest: true,
          body: json.encode(profileLoginRequest.toJson()),
          path: "/authentication/profile",
          out: (dynamic json) => json);
      print(response['token']);
      _httpClient.setHttpHeader(HttpHeaders.authorizationHeader, "Bearer ${response['token']}");
      return LoginResponse.fromJson(response);
    } catch (Error) {
      return LoginResponse()..token = '-1';
    }
  }
}

enum AuthenticationResult { bad_credentials, error, success }
