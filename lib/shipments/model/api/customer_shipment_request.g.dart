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
