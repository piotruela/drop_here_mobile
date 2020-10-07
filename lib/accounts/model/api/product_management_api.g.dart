// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_management_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
