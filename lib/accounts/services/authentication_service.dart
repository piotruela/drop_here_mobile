import 'dart:convert';

import 'package:drop_here_mobile/accounts/model/api/authentication_api.dart';
import 'package:drop_here_mobile/app_storage/app_storage_service.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:get/get.dart';

class AuthenticationService {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();
  final AppStorageService _appStorageService = Get.find<AppStorageService>();

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
          out: (dynamic json) => (json));
      var loginResponse = LoginResponse.fromJson(response);
      return await _appStorageService.successfullyLoggedIn(loginResponse);
    } catch (error) {
      throw Exception();
    }
  }

  Future<void> logOutFromAccount() async {
    return await _appStorageService.loggedOut();
  }

  Future<LoginResponse> logOutFromProfile() async {
    try {
      final Map<String, dynamic> response = await _httpClient.delete(
          canRepeatRequest: true, path: '/authentication/profile', out: (dynamic json) => (json));
      var loginResponse = LoginResponse.fromJson(response);
      return await _appStorageService.successfullyLoggedIn(loginResponse);
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
      var loginResponse = LoginResponse.fromJson(response);
      return await _appStorageService.successfullyLoggedIn(loginResponse);
    } catch (Error) {
      throw Exception();
    }
  }
}

enum AuthenticationResult { bad_credentials, error, success }
