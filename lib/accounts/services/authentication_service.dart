import 'dart:convert';
import 'dart:io';

import 'package:drop_here_mobile/accounts/model/credentials.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:get/get.dart';

class AuthenticationService {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();

  AuthenticationService();

  Future<AuthenticationResult> authenticate(LoginCredentials credentials) async {
    try {
      Map<String, dynamic> response = await _httpClient.post(
          canRepeatRequest: true,
          body: json.encode(credentials.toJson()),
          path: '/authentication',
          out: (_) => (_));
      print(response['token']);
      _httpClient.setHttpHeader(HttpHeaders.authorizationHeader, "Bearer ${response['token']}");
      return AuthenticationResult.success;
    } catch (error) {
      return (error is HttpStatusException && error.statusCode == 401)
          ? AuthenticationResult.bad_credentials
          : AuthenticationResult.error;
    }
  }
}

enum AuthenticationResult { bad_credentials, error, success }
