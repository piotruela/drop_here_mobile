// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_management_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpotManagementRequest _$SpotManagementRequestFromJson(
    Map<String, dynamic> json) {
  return SpotManagementRequest(
    description: json['description'] as String,
    estimatedRadiusMaters: json['estimatedRadiusMaters'] as int,
    hidden: json['hidden'] as bool,
    name: json['name'] as String,
    password: json['password'] as String,
    requiredAccept: json['requiredAccept'] as bool,
    requiredPassword: json['requiredPassword'] as bool,
    xcoordinate: (json['xcoordinate'] as num)?.toDouble(),
    ycoordinate: (json['ycoordinate'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$SpotManagementRequestToJson(
        SpotManagementRequest instance) =>
    <String, dynamic>{
      'description': instance.description,
      'estimatedRadiusMaters': instance.estimatedRadiusMaters,
      'hidden': instance.hidden,
      'name': instance.name,
      'password': instance.password,
      'requiredAccept': instance.requiredAccept,
      'requiredPassword': instance.requiredPassword,
      'xcoordinate': instance.xcoordinate,
      'ycoordinate': instance.ycoordinate,
    };

SpotCompanyResponse _$SpotCompanyResponseFromJson(Map<String, dynamic> json) {
  return SpotCompanyResponse(
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    id: json['id'] as int,
    lastUpdatedAt: json['lastUpdatedAt'] == null
        ? null
        : DateTime.parse(json['lastUpdatedAt'] as String),
    description: json['description'] as String,
    estimatedRadiusMaters: json['estimatedRadiusMaters'] as int,
    hidden: json['hidden'] as bool,
    name: json['name'] as String,
    password: json['password'] as String,
    requiredAccept: json['requiredAccept'] as bool,
    requiredPassword: json['requiredPassword'] as bool,
    xcoordinate: (json['xcoordinate'] as num)?.toDouble(),
    ycoordinate: (json['ycoordinate'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$SpotCompanyResponseToJson(
        SpotCompanyResponse instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'description': instance.description,
      'estimatedRadiusMaters': instance.estimatedRadiusMaters,
      'hidden': instance.hidden,
      'id': instance.id,
      'lastUpdatedAt': instance.lastUpdatedAt?.toIso8601String(),
      'name': instance.name,
      'password': instance.password,
      'requiredAccept': instance.requiredAccept,
      'requiredPassword': instance.requiredPassword,
      'xcoordinate': instance.xcoordinate,
      'ycoordinate': instance.ycoordinate,
    };

SpotMembershipPage _$SpotMembershipPageFromJson(Map<String, dynamic> json) {
  return SpotMembershipPage()
    ..content = (json['content'] as List)
        ?.map((e) => e == null
            ? null
            : SpotCompanyMembershipResponse.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$SpotMembershipPageToJson(SpotMembershipPage instance) =>
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

SpotCompanyMembershipResponse _$SpotCompanyMembershipResponseFromJson(
    Map<String, dynamic> json) {
  return SpotCompanyMembershipResponse(
    customerId: json['customerId'] as int,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    membershipStatus: json['membershipStatus'],
  );
}

Map<String, dynamic> _$SpotCompanyMembershipResponseToJson(
        SpotCompanyMembershipResponse instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'membershipStatus': instance.membershipStatus,
    };

SpotCompanyMembershipManagementRequest
    _$SpotCompanyMembershipManagementRequestFromJson(
        Map<String, dynamic> json) {
  return SpotCompanyMembershipManagementRequest(
    membershipStatus: json['membershipStatus'],
  );
}

Map<String, dynamic> _$SpotCompanyMembershipManagementRequestToJson(
        SpotCompanyMembershipManagementRequest instance) =>
    <String, dynamic>{
      'membershipStatus': instance.membershipStatus,
    };
