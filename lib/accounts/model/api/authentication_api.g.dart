// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse()
    ..token = json['token'] as String
    ..tokenValidUntil = json['tokenValidUntil'] == null
        ? null
        : DateTime.parse(json['tokenValidUntil'] as String);
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'tokenValidUntil': instance.tokenValidUntil?.toIso8601String(),
    };

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) {
  return LoginRequest(
    mail: json['mail'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'mail': instance.mail,
      'password': instance.password,
    };

ProfileLoginRequest _$ProfileLoginRequestFromJson(Map<String, dynamic> json) {
  return ProfileLoginRequest(
    profileUid: json['profileUid'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$ProfileLoginRequestToJson(
        ProfileLoginRequest instance) =>
    <String, dynamic>{
      'profileUid': instance.profileUid,
      'password': instance.password,
    };
