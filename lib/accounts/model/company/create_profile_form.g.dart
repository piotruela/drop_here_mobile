// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_profile_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateProfileForm _$CreateProfileFormFromJson(Map<String, dynamic> json) {
  return CreateProfileForm(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$CreateProfileFormToJson(CreateProfileForm instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'password': instance.password,
    };
