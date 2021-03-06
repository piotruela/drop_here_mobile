// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationTokenManagementRequest _$NotificationTokenManagementRequestFromJson(
    Map<String, dynamic> json) {
  return NotificationTokenManagementRequest(
    broadcastingServiceType: _$enumDecodeNullable(
        _$BroadcastingServiceTypeEnumMap, json['broadcastingServiceType']),
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$NotificationTokenManagementRequestToJson(
        NotificationTokenManagementRequest instance) =>
    <String, dynamic>{
      'broadcastingServiceType':
          _$BroadcastingServiceTypeEnumMap[instance.broadcastingServiceType],
      'token': instance.token,
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

const _$BroadcastingServiceTypeEnumMap = {
  BroadcastingServiceType.FIREBASE: 'FIREBASE',
  BroadcastingServiceType.LOCAL_NOTIFICATIONS: 'LOCAL_NOTIFICATIONS',
};
