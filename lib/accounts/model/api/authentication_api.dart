import 'package:json_annotation/json_annotation.dart';

import 'account_management_api.dart';

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

enum ExternalAuthenticationProviderType { FACEBOOK }

@JsonSerializable()
class ExternalAuthenticationProviderLoginRequest {
  final String code;
  final String provider;
  final String redirectUri;

  ExternalAuthenticationProviderLoginRequest(this.code, this.provider, this.redirectUri);

  factory ExternalAuthenticationProviderLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$ExternalAuthenticationProviderLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExternalAuthenticationProviderLoginRequestToJson(this);
}

@JsonSerializable()
class AuthenticationResponse {
  int accountId;
  AccountType accountType;
  List<String> roles;
  String tokenValidUntil;
  String mail;
  String accountStatus;
  bool hasCompanyData;
  bool hasCustomerData;
  bool hasProfile;
  bool loggedOnProfile;
  String profileUid;
  String profileFirstName;
  String profileLastName;
  String profileType;
  bool streamingPosition;

  AuthenticationResponse(
      this.accountId,
      this.accountType,
      this.roles,
      this.tokenValidUntil,
      this.mail,
      this.accountStatus,
      this.hasCompanyData,
      this.hasCustomerData,
      this.hasProfile,
      this.loggedOnProfile,
      this.profileUid,
      this.profileFirstName,
      this.profileLastName,
      this.profileType,
      this.streamingPosition);

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
