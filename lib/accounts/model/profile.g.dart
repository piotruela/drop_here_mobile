// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile()
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..profileType =
        _$enumDecodeNullable(_$ProfileTypeEnumMap, json['profileType'])
    ..profileUid = json['profileUid'] as String
    ..status = _$enumDecodeNullable(_$AccountStatusEnumMap, json['status']);
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profileType': _$ProfileTypeEnumMap[instance.profileType],
      'profileUid': instance.profileUid,
      'status': _$AccountStatusEnumMap[instance.status],
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

const _$ProfileTypeEnumMap = {
  ProfileType.MAIN: 'MAIN',
  ProfileType.SUBPROFILE: 'SUBPROFILE',
};

const _$AccountStatusEnumMap = {
  AccountStatus.ACTIVE: 'ACTIVE',
  AccountStatus.INACTIVE: 'INACTIVE',
};
