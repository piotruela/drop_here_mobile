import 'dart:io';

import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:drop_here_mobile/counter/bloc/registration_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class RegistrationService {
  final Map<String, String> _headers = {HttpHeaders.contentTypeHeader: "application/json"};
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();
  final String path;

  RegistrationService({this.path});

  Future<RegistrationResult> register(RegistrationCredentials registrationCredentials) async {
    try {
      Map<String, dynamic> response = await _httpClient.post(canRepeatRequest: true,
          headers: _headers,
          body: '{"accountType": "${describeEnum(registrationCredentials.accountType)}","mail": "${registrationCredentials
              .mail}", "password": "${registrationCredentials.password}"}',
          path: path,
          out: (_) => (_));
      print(response['token']);
      _httpClient.setHttpHeader(HttpHeaders.authorizationHeader, "Bearer ${response['token']}");
      return RegistrationResult.account_created;
    }
    catch(error){
      return RegistrationResult.error;
    }
  }
}

enum RegistrationResult {
  account_created,
  error,
}

class RegistrationCredentials {
  final AccountType accountType;
  final String mail;
  final String password;

  RegistrationCredentials({this.accountType, this.mail, this.password});
}