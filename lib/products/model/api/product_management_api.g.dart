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

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'description': instance.description,
      'name': instance.name,
      'price': instance.price,
      'productCustomizationWrappers': instance.productCustomizationWrappers,
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
    customizations: (json['customizations'] as List)
        ?.map((e) => e == null
            ? null
            : ProductCustomizationRequest.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    heading: json['heading'] as String,
    type: _$enumDecodeNullable(_$CustomizationTypeEnumMap, json['type']),
  )..required = json['required'] as bool;
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
    customizations: (json['customizations'] as List)
        ?.map((e) => e == null
            ? null
            : ProductCustomizationResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    heading: json['heading'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$ProductCustomizationWrapperResponseToJson(
        ProductCustomizationWrapperResponse instance) =>
    <String, dynamic>{
      'customizations': instance.customizations,
      'heading': instance.heading,
      'type': instance.type,
    };

ProductCustomizationResponse _$ProductCustomizationResponseFromJson(
    Map<String, dynamic> json) {
  return ProductCustomizationResponse(
    price: (json['price'] as num)?.toDouble(),
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$ProductCustomizationResponseToJson(
        ProductCustomizationResponse instance) =>
    <String, dynamic>{
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
