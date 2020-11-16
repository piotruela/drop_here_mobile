// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_management_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) {
  return ProductResponse(
    id: json['id'] as int,
    category: json['category'] as String,
    description: json['description'] as String,
    name: json['name'] as String,
    price: (json['price'] as num)?.toDouble(),
    drops: (json['drops'] as List)
        ?.map((e) => e == null
            ? null
            : DropProductResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    customizationsWrappers: (json['customizationsWrappers'] as List)
        ?.map((e) => e == null
            ? null
            : ProductCustomizationWrapperResponse.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
    unit: json['unit'] as String,
    unitFraction: (json['unitFraction'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'description': instance.description,
      'name': instance.name,
      'price': instance.price,
      'drops': instance.drops,
      'customizationsWrappers': instance.customizationsWrappers,
      'unit': instance.unit,
      'unitFraction': instance.unitFraction,
    };

ProductManagementRequest _$ProductManagementRequestFromJson(
    Map<String, dynamic> json) {
  return ProductManagementRequest(
    category: json['category'] as String,
    description: json['description'] as String,
    name: json['name'] as String,
    price: (json['price'] as num)?.toDouble(),
    productCustomizationWrappers: (json['productCustomizationWrappers'] as List)
        ?.map((e) => e == null
            ? null
            : ProductCustomizationWrapperRequest.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
    unit: json['unit'] as String,
    unitFraction: (json['unitFraction'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ProductManagementRequestToJson(
        ProductManagementRequest instance) =>
    <String, dynamic>{
      'category': instance.category,
      'description': instance.description,
      'name': instance.name,
      'price': instance.price,
      'productCustomizationWrappers': instance.productCustomizationWrappers,
      'unit': instance.unit,
      'unitFraction': instance.unitFraction,
    };

ProductCustomizationWrapperRequest _$ProductCustomizationWrapperRequestFromJson(
    Map<String, dynamic> json) {
  return ProductCustomizationWrapperRequest(
    customizations: json['customizations'],
    heading: json['heading'] as String,
    type: _$enumDecodeNullable(_$CustomizationTypeEnumMap, json['type']),
    required: json['required'] as bool,
  );
}

Map<String, dynamic> _$ProductCustomizationWrapperRequestToJson(
        ProductCustomizationWrapperRequest instance) =>
    <String, dynamic>{
      'customizations': instance.customizations,
      'heading': instance.heading,
      'type': _$CustomizationTypeEnumMap[instance.type],
      'required': instance.required,
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

const _$CustomizationTypeEnumMap = {
  CustomizationType.SINGLE: 'SINGLE',
  CustomizationType.MULTIPLE: 'MULTIPLE',
};

ProductCustomizationRequest _$ProductCustomizationRequestFromJson(
    Map<String, dynamic> json) {
  return ProductCustomizationRequest(
    price: (json['price'] as num)?.toDouble(),
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$ProductCustomizationRequestToJson(
        ProductCustomizationRequest instance) =>
    <String, dynamic>{
      'price': instance.price,
      'value': instance.value,
    };

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product()
    ..category = json['category'] as String
    ..customizationsWrappers = (json['customizationsWrappers'] as List)
        ?.map((e) => e == null
            ? null
            : ProductCustomizationWrapperResponse.fromJson(
                e as Map<String, dynamic>))
        ?.toList()
    ..description = json['description'] as String
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..price = (json['price'] as num)?.toDouble()
    ..unit = json['unit'] as String
    ..unitFraction = (json['unitFraction'] as num)?.toDouble();
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'category': instance.category,
      'customizationsWrappers': instance.customizationsWrappers,
      'description': instance.description,
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'unit': instance.unit,
      'unitFraction': instance.unitFraction,
    };

ProductCustomizationWrapperResponse
    _$ProductCustomizationWrapperResponseFromJson(Map<String, dynamic> json) {
  return ProductCustomizationWrapperResponse(
    id: json['id'] as int,
    customizations: (json['customizations'] as List)
        ?.map((e) => e == null
            ? null
            : ProductCustomizationResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    heading: json['heading'] as String,
    required: json['required'] as bool,
    type: _$enumDecodeNullable(_$CustomizationTypeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$ProductCustomizationWrapperResponseToJson(
        ProductCustomizationWrapperResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customizations': instance.customizations,
      'heading': instance.heading,
      'required': instance.required,
      'type': _$CustomizationTypeEnumMap[instance.type],
    };

ProductCustomizationResponse _$ProductCustomizationResponseFromJson(
    Map<String, dynamic> json) {
  return ProductCustomizationResponse(
    id: json['id'] as int,
    price: (json['price'] as num)?.toDouble(),
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$ProductCustomizationResponseToJson(
        ProductCustomizationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'value': instance.value,
    };

ProductCategoryResponse _$ProductCategoryResponseFromJson(
    Map<String, dynamic> json) {
  return ProductCategoryResponse(
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$ProductCategoryResponseToJson(
        ProductCategoryResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

ProductUnitResponse _$ProductUnitResponseFromJson(Map<String, dynamic> json) {
  return ProductUnitResponse(
    name: json['name'] as String,
    fractionable: json['fractionable'] as bool,
  );
}

Map<String, dynamic> _$ProductUnitResponseToJson(
        ProductUnitResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'fractionable': instance.fractionable,
    };

DropProductResponse _$DropProductResponseFromJson(Map<String, dynamic> json) {
  return DropProductResponse(
    uid: json['uid'] as String,
    name: json['name'] as String,
    routeProduct: json['routeProduct'] == null
        ? null
        : RouteProductProductResponse.fromJson(
            json['routeProduct'] as Map<String, dynamic>),
    description: json['description'] as String,
    status: _$enumDecodeNullable(_$DropStatusEnumMap, json['status']),
    startTime: json['startTime'] == null
        ? null
        : DateTime.parse(json['startTime'] as String),
    endTime: json['endTime'] == null
        ? null
        : DateTime.parse(json['endTime'] as String),
    spotUid: json['spotUid'] as String,
    spotName: json['spotName'] as String,
    spotXCoordinate: (json['spotXCoordinate'] as num)?.toDouble(),
    spotYCoordinate: (json['spotYCoordinate'] as num)?.toDouble(),
    spotEstimatedRadiusMeters: json['spotEstimatedRadiusMeters'] as int,
    spotDescription: json['spotDescription'] as String,
  );
}

Map<String, dynamic> _$DropProductResponseToJson(
        DropProductResponse instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'routeProduct': instance.routeProduct,
      'description': instance.description,
      'status': _$DropStatusEnumMap[instance.status],
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'spotUid': instance.spotUid,
      'spotName': instance.spotName,
      'spotXCoordinate': instance.spotXCoordinate,
      'spotYCoordinate': instance.spotYCoordinate,
      'spotEstimatedRadiusMeters': instance.spotEstimatedRadiusMeters,
      'spotDescription': instance.spotDescription,
    };

const _$DropStatusEnumMap = {
  DropStatus.UNPREPARED: 'UNPREPARED',
  DropStatus.PREPARED: 'PREPARED',
  DropStatus.DELAYED: 'DELAYED',
  DropStatus.CANCELLED: 'CANCELLED',
  DropStatus.FINISHED: 'FINISHED',
  DropStatus.LIVE: 'LIVE',
};

RouteProductProductResponse _$RouteProductProductResponseFromJson(
    Map<String, dynamic> json) {
  return RouteProductProductResponse(
    id: json['id'] as int,
    amount: (json['amount'] as num)?.toDouble(),
    limitedAmount: json['limitedAmount'] as bool,
    originalProductId: json['originalProductId'] as int,
    price: (json['price'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$RouteProductProductResponseToJson(
        RouteProductProductResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'limitedAmount': instance.limitedAmount,
      'originalProductId': instance.originalProductId,
      'price': instance.price,
    };
