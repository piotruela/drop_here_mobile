// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_shipment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipmentCompanyDecisionRequest _$ShipmentCompanyDecisionRequestFromJson(
    Map<String, dynamic> json) {
  return ShipmentCompanyDecisionRequest(
    comment: json['comment'] as String,
    companyDecision:
        _$enumDecodeNullable(_$CompanyDecisionEnumMap, json['companyDecision']),
  );
}

Map<String, dynamic> _$ShipmentCompanyDecisionRequestToJson(
        ShipmentCompanyDecisionRequest instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'companyDecision': _$CompanyDecisionEnumMap[instance.companyDecision],
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

const _$CompanyDecisionEnumMap = {
  CompanyDecision.REJECT: 'REJECT',
  CompanyDecision.ACCEPT: 'ACCEPT',
  CompanyDecision.CANCEL: 'CANCEL',
  CompanyDecision.DELIVER: 'DELIVER',
};
