import 'package:drop_here_mobile/accounts/model/api/authentication_api.dart';
import 'package:drop_here_mobile/notifications/services/notifications_configuration_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AppStorageService {
  final FlutterSecureStorage _persistence = new FlutterSecureStorage();
  final NotificationsConfigurationService _notificationsConfigurationService =
      Get.find<NotificationsConfigurationService>();

  static const String _AUTHORIZATION_TOKEN_PERSISTENCE_KEY = 'authorization_token';
  static const String _AUTHORIZATION_TOKEN_VALID_UNTIL_PERSISTENCE_KEY =
      'authorization_token_valid_until';

  bool authenticated = false;
  String authenticationToken = "";
  String authorizationHeader = "";
  DateTime authenticationTokenValidUntil = DateTime.now().subtract(new Duration(days: 69 * 2137));

  Future<void> init() async {
    return await loadPersistentAuthentication()
        .then((_) => authenticated
            ? _notificationsConfigurationService.configureNotifications()
            : Future.value())
        .catchError((onError) {
      print(onError);
    });
  }

  Future loadPersistentAuthentication() async {
    var token = await _persistence.read(key: _AUTHORIZATION_TOKEN_PERSISTENCE_KEY);
    var validUntilString =
        await _persistence.read(key: _AUTHORIZATION_TOKEN_VALID_UNTIL_PERSISTENCE_KEY);
    if (validUntilString != null) {
      try {
        var validUntil = DateTime.parse(validUntilString);
        if (validUntil.isAfter(DateTime.now())) {
          print('Loaded authentication info from persistent storage');
          authenticationToken = token;
          authenticationTokenValidUntil = validUntil;
          authenticated = true;
        }
      } catch (error) {
        print(
            'Error during parsing authorization token valid until date from persistent storage: {$validUntilString} ${error.toString()}');
      }
    }
  }

  Future<LoginResponse> successfullyLoggedIn(LoginResponse loginResponse) async {
    authenticated = true;
    authenticationToken = loginResponse.token;
    authorizationHeader = "Bearer $authenticationToken";
    authenticationTokenValidUntil = loginResponse.tokenValidUntil;
    print(loginResponse.token);
    return _persist()
        .catchError((error) => print('Failed to persist data on storage' + error.toString()))
        .then((_) => _notificationsConfigurationService.configureNotifications())
        .catchError((error) => print('Failed to configure notifications ' + error.toString()))
        .then((value) => Future.value(loginResponse));
  }

  Future<void> loggedOut() async {
    return await _persistence
        .delete(key: _AUTHORIZATION_TOKEN_PERSISTENCE_KEY)
        .then((_) => _persistence.delete(key: _AUTHORIZATION_TOKEN_VALID_UNTIL_PERSISTENCE_KEY))
        .then((_) {
      authenticated = false;
      authenticationToken = "";
      authenticationTokenValidUntil = DateTime.now().subtract(Duration(days: 69 * 2137));
    });
  }

  Future<void> _persist() async {
    return await _persistence
        .write(key: _AUTHORIZATION_TOKEN_PERSISTENCE_KEY, value: authenticationToken)
        .then((_) => _persistence.write(
            key: _AUTHORIZATION_TOKEN_VALID_UNTIL_PERSISTENCE_KEY,
            value: authenticationTokenValidUntil.toIso8601String()));
  }
}
