// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_management_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) {
  return Company()
    ..country = json['country'] as String
    ..name = json['name'] as String
    ..registered = json['registered'] as bool
    ..uid = json['uid'] as String
    ..visibilityStatus = _$enumDecodeNullable(
        _$VisibilityStatusEnumMap, json['visibilityStatus']);
}

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'country': instance.country,
      'name': instance.name,
      'registered': instance.registered,
      'uid': instance.uid,
      'visibilityStatus': _$VisibilityStatusEnumMap[instance.visibilityStatus],
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

const _$VisibilityStatusEnumMap = {
  VisibilityStatus.VISIBLE: 'VISIBLE',
  VisibilityStatus.HIDDEN: 'HIDDEN',
};

CompanyManagementRequest _$CompanyManagementRequestFromJson(
    Map<String, dynamic> json) {
  return CompanyManagementRequest(
    companyName: json['name'] as String,
    countryName: json['country'] as String,
    visibility: json['visibilityStatus'] as String,
  );
}

Map<String, dynamic> _$CompanyManagementRequestToJson(
        CompanyManagementRequest instance) =>
    <String, dynamic>{
      'name': instance.companyName,
      'country': instance.countryName,
      'visibilityStatus': instance.visibility,
    };

CompanyCustomerManagementRequest _$CompanyCustomerManagementRequestFromJson(
    Map<String, dynamic> json) {
  return CompanyCustomerManagementRequest(
    block: json['block'] as bool,
  );
}

Map<String, dynamic> _$CompanyCustomerManagementRequestToJson(
        CompanyCustomerManagementRequest instance) =>
    <String, dynamic>{
      'block': instance.block,
    };

ResourceOperationResponse _$ResourceOperationResponseFromJson(
    Map<String, dynamic> json) {
  return ResourceOperationResponse()
    ..id = json['id'] as int
    ..operationStatus =
        _$enumDecodeNullable(_$OperationStatusEnumMap, json['operationStatus']);
}

Map<String, dynamic> _$ResourceOperationResponseToJson(
        ResourceOperationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'operationStatus': _$OperationStatusEnumMap[instance.operationStatus],
    };

const _$OperationStatusEnumMap = {
  OperationStatus.CREATED: 'CREATED',
  OperationStatus.UPDATED: 'UPDATED',
  OperationStatus.DELETED: 'DELETED',
  OperationStatus.ERROR: 'ERROR',
};
