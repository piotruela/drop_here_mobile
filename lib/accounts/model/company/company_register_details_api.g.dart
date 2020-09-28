// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_register_details_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyDetails _$CompanyDetailsFromJson(Map<String, dynamic> json) {
  return CompanyDetails(
    companyName: json['name'] as String,
    countryName: json['country'] as String,
    visibility: json['visibilityStatus'] as bool,
  );
}

Map<String, dynamic> _$CompanyDetailsToJson(CompanyDetails instance) => <String, dynamic>{
      'name': instance.companyName,
      'country': instance.countryName,
      'visibilityStatus': instance.visibility,
    };
