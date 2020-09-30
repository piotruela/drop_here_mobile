// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationCredentials _$RegistrationCredentialsFromJson(
    Map<String, dynamic> json) {
  return RegistrationCredentials(
    accountType:
        _$enumDecodeNullable(_$AccountTypeEnumMap, json['accountType']),
    mail: json['mail'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$RegistrationCredentialsToJson(
    RegistrationCredentials instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('accountType', _$AccountTypeEnumMap[instance.accountType]);
  writeNotNull('mail', instance.mail);
  writeNotNull('password', instance.password);
  return val;
}

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

LoginCredentials _$LoginCredentialsFromJson(Map<String, dynamic> json) {
  return LoginCredentials(
    mail: json['mail'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$LoginCredentialsToJson(LoginCredentials instance) =>
    <String, dynamic>{
      'mail': instance.mail,
      'password': instance.password,
    };
