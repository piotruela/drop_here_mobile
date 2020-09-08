import 'dart:io';

import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:get/get.dart';

class AuthenticationService {
  final Map<String, String> _headers = {HttpHeaders.contentTypeHeader: "application/json"};
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();
  final String path;

  AuthenticationService(this.path);

  Future<AuthenticationResult> authenticate(LoginCredentials credentials) async {
    try {
      Map<String, dynamic> response = await _httpClient.post(canRepeatRequest: true,
          headers: _headers,
          body: '{"mail": "${credentials.mail}", "password": "${credentials.password}"}',
          path: path,
      out: (_) => (_));
      print(response['token']);
      _httpClient.setHttpHeader(HttpHeaders.authorizationHeader, "Bearer ${response['token']}");
      return AuthenticationResult.success;
    }
    catch(error){
      return (error is HttpStatusException && error.statusCode == 401)
      ? AuthenticationResult.bad_credentials
      : AuthenticationResult.error;
    }
  }
}

enum AuthenticationResult {
  bad_credentials,
  error,
  success
}

class LoginCredentials {
  final String mail;
  final String password;

  LoginCredentials({this.mail, this.password});
}