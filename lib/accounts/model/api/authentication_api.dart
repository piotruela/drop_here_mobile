import 'package:json_annotation/json_annotation.dart';

part 'authentication_api.g.dart';

@JsonSerializable()
class LoginResponse {
  String token;
  DateTime tokenValidUntil;

  LoginResponse();

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class LoginRequest {
  final String mail;
  final String password;

  LoginRequest({this.mail, this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  LoginRequest copyWith({String mail, String password}) {
    return LoginRequest(mail: mail ?? this.mail, password: password ?? this.password);
  }
}

@JsonSerializable()
class ProfileLoginRequest {
  final String profileUid;
  final String password;

  ProfileLoginRequest({this.profileUid, this.password});

  factory ProfileLoginRequest.fromJson(Map<String, dynamic> json) =>
        _$ProfileLoginRequestFromJson(json);
    Map<String, dynamic> toJson() => _$ProfileLoginRequestToJson(this);

    ProfileLoginRequest copyWith({String profileUid, String password}) {
      return ProfileLoginRequest(
          profileUid: profileUid ?? this.profileUid, password: password ?? this.password);
  }
}

enum ExternalAuthenticationProviderType{
  FACEBOOK
}
@JsonSerializable()
class ExternalAuthenticationProviderLoginRequest{
  final String code;
  final String provider;
  final String redirectUri;

  ExternalAuthenticationProviderLoginRequest(this.code, this.provider, this.redirectUri);

  factory ExternalAuthenticationProviderLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$ExternalAuthenticationProviderLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExternalAuthenticationProviderLoginRequestToJson(this);
}
