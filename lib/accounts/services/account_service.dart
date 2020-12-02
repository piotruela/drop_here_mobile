import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/authentication_api.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/app_storage/app_storage_service.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as di;

class AccountService {
  final DhHttpClient _httpClient = di.Get.find<DhHttpClient>();
  final AppStorageService _appStorageService = di.Get.find<AppStorageService>();

  Future<LoginResponse> createNewAccount(AccountCreationRequest accountCreationRequest) async {
    try {
      Map<String, dynamic> response = await _httpClient.post(
          canRepeatRequest: true,
          body: json.encode(accountCreationRequest.toJson()),
          path: "/accounts",
          out: (dynamic json) => json);
      var loginResponse = LoginResponse.fromJson(response);
      return await _appStorageService.successfullyLoggedIn(loginResponse);
    } catch (error) {
      throw Exception();
    }
  }

  Future<AccountInfoResponse> fetchAccountDetails() async {
    dynamic response = await _httpClient.get(canRepeatRequest: true, path: "/accounts", out: (dynamic json) => json);
    return AccountInfoResponse.fromJson(response);
  }

  Future<void> createAdminProfile(AccountProfileCreationRequest form) async {
    try {
      dynamic response = await _httpClient.post(
          canRepeatRequest: true,
          body: json.encode(form.toJson()),
          path: "/accounts/profiles",
          out: (dynamic json) => json);
      var loginResponse = LoginResponse.fromJson(response);
      return await _appStorageService.successfullyLoggedIn(loginResponse);
    } catch (Error) {
      return -1;
    }
  }

  Future<void> createBasicProfile(AccountProfileCreationRequest form) async {
    try {
      return await _httpClient.post(
          canRepeatRequest: true,
          body: json.encode(form.toJson()),
          path: "/accounts/profiles",
          out: (dynamic json) => json);
    } catch (Error) {
      return Future.value();
    }
  }

  Future<void> updateProfile(AccountProfileUpdateRequest accountProfileUpdateRequest) async {
    try {
      return await _httpClient.patch(
          canRepeatRequest: true,
          body: json.encode(accountProfileUpdateRequest.toJson()),
          path: "/accounts/profiles",
          out: (dynamic json) => json);
    } catch (Error) {
      return Future.value();
    }
  }

  Future<NetworkImage> getProfilePhoto(String profileUid) async {
    return NetworkImage("${_httpClient.baseUrl}/accounts/profiles/$profileUid/images");
  }

  Future<ResourceOperationResponse> uploadProfilePhoto(File file) async {
    try {
      Dio dio = new Dio();
      dio.options.headers[HttpHeaders.authorizationHeader] = _appStorageService.authorizationHeader;
      MultipartFile multipartFile = await MultipartFile.fromFile(file.path);
      FormData formData = FormData.fromMap({"image": multipartFile});
      Response response = await dio.post("${_httpClient.baseUrl}/accounts/profiles/images", data: formData);
      return ResourceOperationResponse.fromJson(response.data);
    } catch (error) {
      return ResourceOperationResponse()..operationStatus = OperationStatus.ERROR;
    }
  }

  Future<List<ProfileInfoResponse>> fetchProfiles() async {
    dynamic response = await _httpClient.get(canRepeatRequest: true, path: "/accounts", out: (dynamic json) => json);
    AccountInfoResponse account = AccountInfoResponse.fromJson(response);
    return account.profiles;
  }
}
