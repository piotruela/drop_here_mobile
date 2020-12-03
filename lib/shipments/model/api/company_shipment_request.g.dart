// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_shipment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipmentDecisionRequest _$ShipmentDecisionRequestFromJson(
    Map<String, dynamic> json) {
  return ShipmentDecisionRequest(
    comment: json['comment'] as String,
    companyDecision:
        _$enumDecodeNullable(_$DecisionEnumMap, json['companyDecision']),
  );
}

Map<String, dynamic> _$ShipmentDecisionRequestToJson(
        ShipmentDecisionRequest instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'companyDecision': _$DecisionEnumMap[instance.companyDecision],
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

const _$DecisionEnumMap = {
  Decision.REJECT: 'REJECT',
  Decision.ACCEPT: 'ACCEPT',
  Decision.CANCEL: 'CANCEL',
  Decision.DELIVER: 'DELIVER',
};
