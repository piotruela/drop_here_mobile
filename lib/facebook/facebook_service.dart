import 'dart:async';
import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class FacebookResponse {
  final String token;
  final String redirectUri;

  FacebookResponse(this.token, this.redirectUri);
}

class FacebookService {
  final String _clientId = '776211416457721';
  final String _redirectUri = "http://localhost:8080/";
  final String _scope = "&scope=email";
  final String _authorizationEndpoint = "https://www.facebook.com/v2.8/dialog/oauth";

  Future<FacebookResponse> signUp() async {
    final Stream<String> onCode = await _server();
    final String url = "$_authorizationEndpoint?client_id=$_clientId&redirect_uri=$_redirectUri$_scope";
    launch(url, forceWebView: true);
    final String token = await onCode.first;
    await closeWebView();
    return new FacebookResponse(token, _redirectUri);
  }

  Future<Stream<String>> _server() async {
    final StreamController<String> onCode = new StreamController();
    HttpServer server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
    server.listen((HttpRequest request) async {
      final String code = request.uri.queryParameters["code"];
      request.response
        ..statusCode = 200
        ..headers.set("Content-Type", ContentType.html.mimeType);
      await request.response.close();
      await server.close(force: true);
      onCode.add(code);
      await onCode.close();
    });
    return onCode.stream;
  }
}
