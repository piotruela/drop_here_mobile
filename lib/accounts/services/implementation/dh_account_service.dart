import 'dart:convert';
import 'dart:io';

import 'package:drop_here_mobile/accounts/model/company/create_profile_form.dart';
import 'package:drop_here_mobile/accounts/services/account_service.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:get/get.dart';

class DropHereAccountService extends AccountsService {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();

  @override
  Future<int> createProfile(CreateProfileForm form) async {
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
}
