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

ExternalAuthenticationProviderLoginRequest
    _$ExternalAuthenticationProviderLoginRequestFromJson(
        Map<String, dynamic> json) {
  return ExternalAuthenticationProviderLoginRequest(
    json['code'] as String,
    json['provider'] as String,
    json['redirectUri'] as String,
  );
}

Map<String, dynamic> _$ExternalAuthenticationProviderLoginRequestToJson(
        ExternalAuthenticationProviderLoginRequest instance) =>
    <String, dynamic>{
      'code': instance.code,
      'provider': instance.provider,
      'redirectUri': instance.redirectUri,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
    Map<String, dynamic> json) {
  return AuthenticationResponse(
    json['accountId'] as int,
    _$enumDecodeNullable(_$AccountTypeEnumMap, json['accountType']),
    (json['roles'] as List)?.map((e) => e as String)?.toList(),
    json['tokenValidUntil'] as String,
    json['mail'] as String,
    json['accountStatus'] as String,
    json['hasCompanyData'] as bool,
    json['hasCustomerData'] as bool,
    json['hasProfile'] as bool,
    json['loggedOnProfile'] as bool,
    json['profileUid'] as String,
    json['profileFirstName'] as String,
    json['profileLastName'] as String,
    json['profileType'] as String,
    json['streamingPosition'] as bool,
  );
}

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'accountType': _$AccountTypeEnumMap[instance.accountType],
      'roles': instance.roles,
      'tokenValidUntil': instance.tokenValidUntil,
      'mail': instance.mail,
      'accountStatus': instance.accountStatus,
      'hasCompanyData': instance.hasCompanyData,
      'hasCustomerData': instance.hasCustomerData,
      'hasProfile': instance.hasProfile,
      'loggedOnProfile': instance.loggedOnProfile,
      'profileUid': instance.profileUid,
      'profileFirstName': instance.profileFirstName,
      'profileLastName': instance.profileLastName,
      'profileType': instance.profileType,
      'streamingPosition': instance.streamingPosition,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$AccountTypeEnumMap = {
  AccountType.CUSTOMER: 'CUSTOMER',
  AccountType.COMPANY: 'COMPANY',
};
