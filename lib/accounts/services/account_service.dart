import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/authentication_api.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountService {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();

  Future<LoginResponse> createNewAccount(AccountCreationRequest accountCreationRequest) async {
    try {
      Map<String, dynamic> response = await _httpClient.post(
          canRepeatRequest: true,
          body: json.encode(accountCreationRequest.toJson()),
          path: "/accounts",
          out: (dynamic json) => json);
      print(response['token']);
      _httpClient.setHttpHeader(HttpHeaders.authorizationHeader, "Bearer ${response['token']}");
      return LoginResponse.fromJson(response);
    } catch (error) {
      throw Exception();
    }
  }

  Future<AccountInfoResponse> fetchAccountDetails() async {
    dynamic response = await _httpClient.get(
        canRepeatRequest: true, path: "/accounts", out: (dynamic json) => json);
    return AccountInfoResponse.fromJson(response);
  }

  Future<int> createAdminProfile(AccountProfileCreationRequest form) async {
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

  Future<int> createBasicProfile(AccountProfileCreationRequest form) async {
    try {
      await _httpClient.post(
          canRepeatRequest: true,
          body: json.encode(form.toJson()),
          path: "/accounts/profiles",
          out: (dynamic json) => json);
      return 1;
    } catch (Error) {
      return -1;
    }
  }

  Future<int> updateProfile(AccountProfileUpdateRequest accountProfileUpdateRequest) async {
    try {
      await _httpClient.patch(
          canRepeatRequest: true,
          body: json.encode(accountProfileUpdateRequest.toJson()),
          path: "/accounts/profiles",
          out: (dynamic json) => json);
      return 1;
    } catch (Error) {
      return -1;
    }
  }

  Future<NetworkImage> getProfilePhoto(String profileUid) async {
    NetworkImage img =
        NetworkImage("https://drop-here.herokuapp.com/accounts/profiles/$profileUid/images");
    return img;
  }

  Future<ResourceOperationResponse> uploadProfilePhoto(File file) async {
    try {
      Dio dio = new Dio();
      dio.options.headers[HttpHeaders.authorizationHeader] = _httpClient.token;
      MultipartFile multipartFile = await MultipartFile.fromFile(file.path);
      FormData formData = FormData.fromMap({"image": multipartFile});
      Response response = await dio.post("https://drop-here.herokuapp.com/accounts/profiles/images",
          data: formData);
      return ResourceOperationResponse.fromJson(response.data);
    } catch (error) {
      return ResourceOperationResponse()..operationStatus = OperationStatus.ERROR;
    }
  }

  Future<List<ProfileInfoResponse>> fetchProfiles() async {
    dynamic response = await _httpClient.get(
        canRepeatRequest: true, path: "/accounts", out: (dynamic json) => json);
    AccountInfoResponse account = AccountInfoResponse.fromJson(response);
    return account.profiles;
  }
}
