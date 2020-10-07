// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_management_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInfoResponse _$AccountInfoResponseFromJson(Map<String, dynamic> json) {
  return AccountInfoResponse()
    ..accountMailStatus = _$enumDecodeNullable(
        _$AccountMailStatusEnumMap, json['accountMailStatus'])
    ..accountStatus =
        _$enumDecodeNullable(_$AccountStatusEnumMap, json['accountStatus'])
    ..accountType =
        _$enumDecodeNullable(_$AccountTypeEnumMap, json['accountType'])
    ..anyProfileRegistered = json['anyProfileRegistered'] as bool
    ..createdAt = json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String)
    ..mail = json['mail'] as String
    ..profiles = (json['profiles'] as List)
        ?.map((e) => e == null
            ? null
            : ProfileInfoResponse.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AccountInfoResponseToJson(
        AccountInfoResponse instance) =>
    <String, dynamic>{
      'accountMailStatus':
          _$AccountMailStatusEnumMap[instance.accountMailStatus],
      'accountStatus': _$AccountStatusEnumMap[instance.accountStatus],
      'accountType': _$AccountTypeEnumMap[instance.accountType],
      'anyProfileRegistered': instance.anyProfileRegistered,
      'createdAt': instance.createdAt?.toIso8601String(),
      'mail': instance.mail,
      'profiles': instance.profiles,
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

const _$AccountMailStatusEnumMap = {
  AccountMailStatus.CONFIRMED: 'CONFIRMED',
  AccountMailStatus.UNCONFIRMED: 'UNCONFIRMED',
};

const _$AccountStatusEnumMap = {
  AccountStatus.ACTIVE: 'ACTIVE',
  AccountStatus.INACTIVE: 'INACTIVE',
};

const _$AccountTypeEnumMap = {
  AccountType.CUSTOMER: 'CUSTOMER',
  AccountType.COMPANY: 'COMPANY',
};

ProfileInfoResponse _$ProfileInfoResponseFromJson(Map<String, dynamic> json) {
  return ProfileInfoResponse()
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..profileType =
        _$enumDecodeNullable(_$ProfileTypeEnumMap, json['profileType'])
    ..profileUid = json['profileUid'] as String
    ..status = _$enumDecodeNullable(_$AccountStatusEnumMap, json['status']);
}

Map<String, dynamic> _$ProfileInfoResponseToJson(
        ProfileInfoResponse instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profileType': _$ProfileTypeEnumMap[instance.profileType],
      'profileUid': instance.profileUid,
      'status': _$AccountStatusEnumMap[instance.status],
    };

const _$ProfileTypeEnumMap = {
  ProfileType.MAIN: 'MAIN',
  ProfileType.SUBPROFILE: 'SUBPROFILE',
};

AccountCreationRequest _$AccountCreationRequestFromJson(
    Map<String, dynamic> json) {
  return AccountCreationRequest(
    accountType:
        _$enumDecodeNullable(_$AccountTypeEnumMap, json['accountType']),
    mail: json['mail'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$AccountCreationRequestToJson(
        AccountCreationRequest instance) =>
    <String, dynamic>{
      'accountType': _$AccountTypeEnumMap[instance.accountType],
      'mail': instance.mail,
      'password': instance.password,
    };

AccountProfileCreationRequest _$AccountProfileCreationRequestFromJson(
    Map<String, dynamic> json) {
  return AccountProfileCreationRequest(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$AccountProfileCreationRequestToJson(
        AccountProfileCreationRequest instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'password': instance.password,
    };

AccountProfileUpdateRequest _$AccountProfileUpdateRequestFromJson(
    Map<String, dynamic> json) {
  return AccountProfileUpdateRequest(
    json['firstName'] as String,
    json['lastName'] as String,
  );
}

Map<String, dynamic> _$AccountProfileUpdateRequestToJson(
        AccountProfileUpdateRequest instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
