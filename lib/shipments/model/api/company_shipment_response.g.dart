// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_shipment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipmentsPage _$ShipmentsPageFromJson(Map<String, dynamic> json) {
  return ShipmentsPage()
    ..content = (json['content'] as List)
        ?.map((e) => e == null
            ? null
            : ShipmentResponse.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..empty = json['empty'] as bool
    ..first = json['first'] as bool
    ..last = json['last'] as bool
    ..number = json['number'] as int
    ..numberOfElements = json['numberOfElements'] as int
    ..pageable = json['pageable'] == null
        ? null
        : Pageable.fromJson(json['pageable'] as Map<String, dynamic>)
    ..size = json['size'] as int
    ..sort = json['sort'] == null
        ? null
        : Sort.fromJson(json['sort'] as Map<String, dynamic>)
    ..totalElements = json['totalElements'] as int
    ..totalPages = json['totalPages'] as int;
}

Map<String, dynamic> _$ShipmentsPageToJson(ShipmentsPage instance) =>
    <String, dynamic>{
      'content': instance.content,
      'empty': instance.empty,
      'first': instance.first,
      'last': instance.last,
      'number': instance.number,
      'numberOfElements': instance.numberOfElements,
      'pageable': instance.pageable,
      'size': instance.size,
      'sort': instance.sort,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
    };

ShipmentResponse _$ShipmentResponseFromJson(Map<String, dynamic> json) {
  return ShipmentResponse(
    acceptedAt: json['acceptedAt'] == null
        ? null
        : DateTime.parse(json['acceptedAt'] as String),
    cancelRequestedAt: json['cancelRequestedAt'] == null
        ? null
        : DateTime.parse(json['cancelRequestedAt'] as String),
    cancelledAt: json['cancelledAt'] == null
        ? null
        : DateTime.parse(json['cancelledAt'] as String),
    companyComment: json['companyComment'] as String,
    companyName: json['companyName'] as String,
    companyUid: json['companyUid'] as String,
    compromiseAcceptedAt: json['compromiseAcceptedAt'] == null
        ? null
        : DateTime.parse(json['compromiseAcceptedAt'] as String),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    customerComment: json['customerComment'] as String,
    customerFirstName: json['customerFirstName'] as String,
    customerId: json['customerId'] as int,
    customerLastName: json['customerLastName'] as String,
    deliveredAt: json['deliveredAt'] == null
        ? null
        : DateTime.parse(json['deliveredAt'] as String),
    dropUid: json['dropUid'] as String,
    id: json['id'] as int,
    placedAt: json['placedAt'] == null
        ? null
        : DateTime.parse(json['placedAt'] as String),
    flows: (json['flows'] as List)
        ?.map((e) => e == null
            ? null
            : ShipmentFlowResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    products: (json['products'] as List)
        ?.map((e) => e == null
            ? null
            : ShipmentProductResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    rejectedAt: json['rejectedAt'] == null
        ? null
        : DateTime.parse(json['rejectedAt'] as String),
    status: _$enumDecodeNullable(_$ShipmentStatusEnumMap, json['status']),
    summarizedAmount: (json['summarizedAmount'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ShipmentResponseToJson(ShipmentResponse instance) =>
    <String, dynamic>{
      'acceptedAt': instance.acceptedAt?.toIso8601String(),
      'cancelRequestedAt': instance.cancelRequestedAt?.toIso8601String(),
      'cancelledAt': instance.cancelledAt?.toIso8601String(),
      'companyComment': instance.companyComment,
      'companyName': instance.companyName,
      'companyUid': instance.companyUid,
      'compromiseAcceptedAt': instance.compromiseAcceptedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'customerComment': instance.customerComment,
      'customerFirstName': instance.customerFirstName,
      'customerId': instance.customerId,
      'customerLastName': instance.customerLastName,
      'deliveredAt': instance.deliveredAt?.toIso8601String(),
      'dropUid': instance.dropUid,
      'id': instance.id,
      'placedAt': instance.placedAt?.toIso8601String(),
      'products': instance.products,
      'flows': instance.flows,
      'rejectedAt': instance.rejectedAt?.toIso8601String(),
      'status': _$ShipmentStatusEnumMap[instance.status],
      'summarizedAmount': instance.summarizedAmount,
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

const _$ShipmentStatusEnumMap = {
  ShipmentStatus.PLACED: 'PLACED',
  ShipmentStatus.ACCEPTED: 'ACCEPTED',
  ShipmentStatus.CANCEL_REQUESTED: 'CANCEL_REQUESTED',
  ShipmentStatus.CANCELLED: 'CANCELLED',
  ShipmentStatus.DELIVERED: 'DELIVERED',
  ShipmentStatus.REJECTED: 'REJECTED',
};

ShipmentProductResponse _$ShipmentProductResponseFromJson(
    Map<String, dynamic> json) {
  return ShipmentProductResponse(
    customizations: (json['customizations'] as List)
        ?.map((e) => e == null
            ? null
            : ShipmentProductCustomizationResponse.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
    id: json['id'] as int,
    productDescription: json['productDescription'] as String,
    productId: json['productId'] as int,
    productName: json['productName'] as String,
    quantity: (json['quantity'] as num)?.toDouble(),
    summarizedPrice: (json['summarizedPrice'] as num)?.toDouble(),
    unitCustomizationsPrice:
        (json['unitCustomizationsPrice'] as num)?.toDouble(),
    unitPrice: (json['unitPrice'] as num)?.toDouble(),
    unitSummarizedPrice: (json['unitSummarizedPrice'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ShipmentProductResponseToJson(
        ShipmentProductResponse instance) =>
    <String, dynamic>{
      'customizations': instance.customizations,
      'id': instance.id,
      'productDescription': instance.productDescription,
      'productId': instance.productId,
      'productName': instance.productName,
      'quantity': instance.quantity,
      'summarizedPrice': instance.summarizedPrice,
      'unitCustomizationsPrice': instance.unitCustomizationsPrice,
      'unitPrice': instance.unitPrice,
      'unitSummarizedPrice': instance.unitSummarizedPrice,
    };

ShipmentProductCustomizationResponse
    _$ShipmentProductCustomizationResponseFromJson(Map<String, dynamic> json) {
  return ShipmentProductCustomizationResponse(
    customizationPrice: (json['customizationPrice'] as num)?.toDouble(),
    customizationValue: json['customizationValue'] as String,
    wrapperHeading: json['wrapperHeading'] as String,
    wrapperId: json['wrapperId'] as int,
    wrapperType:
        _$enumDecodeNullable(_$CustomizationTypeEnumMap, json['wrapperType']),
  )..id = json['id'] as int;
}

Map<String, dynamic> _$ShipmentProductCustomizationResponseToJson(
        ShipmentProductCustomizationResponse instance) =>
    <String, dynamic>{
      'customizationPrice': instance.customizationPrice,
      'customizationValue': instance.customizationValue,
      'wrapperHeading': instance.wrapperHeading,
      'id': instance.id,
      'wrapperId': instance.wrapperId,
      'wrapperType': _$CustomizationTypeEnumMap[instance.wrapperType],
    };

const _$CustomizationTypeEnumMap = {
  CustomizationType.SINGLE: 'SINGLE',
  CustomizationType.MULTIPLE: 'MULTIPLE',
};

ShipmentFlowResponse _$ShipmentFlowResponseFromJson(Map<String, dynamic> json) {
  return ShipmentFlowResponse(
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    status: _$enumDecodeNullable(_$ShipmentStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$ShipmentFlowResponseToJson(
        ShipmentFlowResponse instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'status': _$ShipmentStatusEnumMap[instance.status],
    };
