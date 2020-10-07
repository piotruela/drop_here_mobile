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
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$ProductCustomizationWrapperRequestToJson(
        ProductCustomizationWrapperRequest instance) =>
    <String, dynamic>{
      'customizations': instance.customizations,
      'heading': instance.heading,
      'type': instance.type,
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
