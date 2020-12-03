// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_observer_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationPayload _$NotificationPayloadFromJson(Map<String, dynamic> json) {
  return NotificationPayload(
    json['title'] as String,
    json['message'] as String,
    _$enumDecodeNullable(
        _$ReferencedSubjectTypeEnumMap, json['referencedSubjectType']),
    json['referencedSubjectId'] as String,
    _$enumDecodeNullable(_$NotificationTypeEnumMap, json['notificationType']),
  );
}

Map<String, dynamic> _$NotificationPayloadToJson(
        NotificationPayload instance) =>
    <String, dynamic>{
      'title': instance.title,
      'message': instance.message,
      'referencedSubjectType':
          _$ReferencedSubjectTypeEnumMap[instance.referencedSubjectType],
      'referencedSubjectId': instance.referencedSubjectId,
      'notificationType': _$NotificationTypeEnumMap[instance.notificationType],
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

const _$ReferencedSubjectTypeEnumMap = {
  ReferencedSubjectType.EMPTY: 'EMPTY',
  ReferencedSubjectType.DROP: 'DROP',
  ReferencedSubjectType.SPOT: 'SPOT',
  ReferencedSubjectType.SHIPMENT: 'SHIPMENT',
  ReferencedSubjectType.UNKNOWN: 'UNKNOWN',
};

const _$NotificationTypeEnumMap = {
  NotificationType.CLICKED_APP_TERMINATED: 'CLICKED_APP_TERMINATED',
  NotificationType.CLICKED_APP_BACKGROUND: 'CLICKED_APP_BACKGROUND',
  NotificationType.CLICKED_VIEW_NOT_DEFINED: 'CLICKED_VIEW_NOT_DEFINED',
  NotificationType.HIDDEN_APP_FOREGROUND: 'HIDDEN_APP_FOREGROUND',
};
