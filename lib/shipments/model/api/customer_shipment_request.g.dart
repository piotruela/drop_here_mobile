// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_shipment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipmentCustomerSubmissionRequest _$ShipmentCustomerSubmissionRequestFromJson(
    Map<String, dynamic> json) {
  return ShipmentCustomerSubmissionRequest(
    comment: json['comment'] as String,
    products: (json['products'] as List)
        ?.map((e) => e == null
            ? null
            : ShipmentProductRequest.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ShipmentCustomerSubmissionRequestToJson(
        ShipmentCustomerSubmissionRequest instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'products': instance.products,
    };

ShipmentProductRequest _$ShipmentProductRequestFromJson(
    Map<String, dynamic> json) {
  return ShipmentProductRequest(
    customizations: (json['customizations'] as List)
        ?.map((e) => e == null
            ? null
            : ShipmentCustomizationRequest.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    quantity: (json['quantity'] as num)?.toDouble(),
    routeProductId: json['routeProductId'] as int,
  );
}

Map<String, dynamic> _$ShipmentProductRequestToJson(
        ShipmentProductRequest instance) =>
    <String, dynamic>{
      'customizations': instance.customizations,
      'quantity': instance.quantity,
      'routeProductId': instance.routeProductId,
    };

ShipmentCustomizationRequest _$ShipmentCustomizationRequestFromJson(
    Map<String, dynamic> json) {
  return ShipmentCustomizationRequest(
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$ShipmentCustomizationRequestToJson(
        ShipmentCustomizationRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

ShipmentCustomerDecisionRequest _$ShipmentCustomerDecisionRequestFromJson(
    Map<String, dynamic> json) {
  return ShipmentCustomerDecisionRequest(
    comment: json['comment'] as String,
    customerDecision: _$enumDecodeNullable(
        _$CustomerDecisionEnumMap, json['customerDecision']),
  );
}

Map<String, dynamic> _$ShipmentCustomerDecisionRequestToJson(
        ShipmentCustomerDecisionRequest instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'customerDecision': _$CustomerDecisionEnumMap[instance.customerDecision],
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

const _$CustomerDecisionEnumMap = {
  CustomerDecision.CANCEL: 'CANCEL',
};

CustomerShipmentRequest _$CustomerShipmentRequestFromJson(
    Map<String, dynamic> json) {
  return CustomerShipmentRequest(
    offset: json['offset'] as int,
    pageNumber: json['pageNumber'] as int,
    pageSize: json['pageSize'] as int,
    paged: json['paged'] as bool,
    sortSorted: json['sortSorted'] as bool,
    sortUnsorted: json['sortUnsorted'] as bool,
    unpaged: json['unpaged'] as bool,
    status: _$enumDecodeNullable(_$ShipmentStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$CustomerShipmentRequestToJson(
        CustomerShipmentRequest instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'paged': instance.paged,
      'sortSorted': instance.sortSorted,
      'sortUnsorted': instance.sortUnsorted,
      'status': _$ShipmentStatusEnumMap[instance.status],
      'unpaged': instance.unpaged,
    };

const _$ShipmentStatusEnumMap = {
  ShipmentStatus.PLACED: 'PLACED',
  ShipmentStatus.ACCEPTED: 'ACCEPTED',
  ShipmentStatus.CANCEL_REQUESTED: 'CANCEL_REQUESTED',
  ShipmentStatus.CANCELLED: 'CANCELLED',
  ShipmentStatus.DELIVERED: 'DELIVERED',
  ShipmentStatus.REJECTED: 'REJECTED',
};
