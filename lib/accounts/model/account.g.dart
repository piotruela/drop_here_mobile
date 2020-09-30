// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account()
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
        ?.map((e) =>
            e == null ? null : Profile.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
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
