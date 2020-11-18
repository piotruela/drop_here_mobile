// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_management_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerManagementRequest _$CustomerManagementRequestFromJson(
    Map<String, dynamic> json) {
  return CustomerManagementRequest(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
  );
}

Map<String, dynamic> _$CustomerManagementRequestToJson(
        CustomerManagementRequest instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };

CustomerInfoResponse _$CustomerInfoResponseFromJson(Map<String, dynamic> json) {
  return CustomerInfoResponse(
    firstName: json['firstName'] as String,
    id: json['id'] as int,
    lastName: json['lastName'] as String,
    registered: json['registered'] as bool,
  );
}

Map<String, dynamic> _$CustomerInfoResponseToJson(
        CustomerInfoResponse instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'id': instance.id,
      'lastName': instance.lastName,
      'registered': instance.registered,
    };
