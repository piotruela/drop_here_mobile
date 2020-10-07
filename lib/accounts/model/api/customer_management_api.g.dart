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
    registered: json['registered'] as bool,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
  );
}

Map<String, dynamic> _$CustomerInfoResponseToJson(
        CustomerInfoResponse instance) =>
    <String, dynamic>{
      'registered': instance.registered,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
