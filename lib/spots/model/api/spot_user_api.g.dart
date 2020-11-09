// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_user_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpotBaseCustomerResponse _$SpotBaseCustomerResponseFromJson(
    Map<String, dynamic> json) {
  return SpotBaseCustomerResponse()
    ..companyName = json['companyName'] as String
    ..companyUid = json['companyUid'] as String
    ..description = json['description'] as String
    ..estimatedRadiusMeters = json['estimatedRadiusMeters'] as int
    ..membershipStatus = _$enumDecodeNullable(
        _$MembershipStatusEnumMap, json['membershipStatus'])
    ..name = json['name'] as String
    ..receiveCancelledNotifications =
        json['receiveCancelledNotifications'] as bool
    ..receiveDelayedNotifications = json['receiveDelayedNotifications'] as bool
    ..receiveFinishedNotifications =
        json['receiveFinishedNotifications'] as bool
    ..receiveLiveNotifications = json['receiveLiveNotifications'] as bool
    ..receivePreparedNotifications =
        json['receivePreparedNotifications'] as bool
    ..requiresAccept = json['requiresAccept'] as bool
    ..requiresPassword = json['requiresPassword'] as bool
    ..uid = json['uid'] as String
    ..xcoordinate = (json['xcoordinate'] as num)?.toDouble()
    ..ycoordinate = (json['ycoordinate'] as num)?.toDouble();
}

Map<String, dynamic> _$SpotBaseCustomerResponseToJson(
        SpotBaseCustomerResponse instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'companyUid': instance.companyUid,
      'description': instance.description,
      'estimatedRadiusMeters': instance.estimatedRadiusMeters,
      'membershipStatus': _$MembershipStatusEnumMap[instance.membershipStatus],
      'name': instance.name,
      'receiveCancelledNotifications': instance.receiveCancelledNotifications,
      'receiveDelayedNotifications': instance.receiveDelayedNotifications,
      'receiveFinishedNotifications': instance.receiveFinishedNotifications,
      'receiveLiveNotifications': instance.receiveLiveNotifications,
      'receivePreparedNotifications': instance.receivePreparedNotifications,
      'requiresAccept': instance.requiresAccept,
      'requiresPassword': instance.requiresPassword,
      'uid': instance.uid,
      'xcoordinate': instance.xcoordinate,
      'ycoordinate': instance.ycoordinate,
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

const _$MembershipStatusEnumMap = {
  MembershipStatus.ACTIVE: 'ACTIVE',
  MembershipStatus.PENDING: 'PENDING',
  MembershipStatus.BLOCKED: 'BLOCKED',
};

SpotDetailedCustomerResponse _$SpotDetailedCustomerResponseFromJson(
    Map<String, dynamic> json) {
  return SpotDetailedCustomerResponse(
    drops: (json['drops'] as List)
        ?.map((e) => e == null
            ? null
            : DropCustomerSpotResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    spot: json['spot'] == null
        ? null
        : SpotBaseCustomerResponse.fromJson(
            json['spot'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SpotDetailedCustomerResponseToJson(
        SpotDetailedCustomerResponse instance) =>
    <String, dynamic>{
      'drops': instance.drops,
      'spot': instance.spot,
    };

SpotJoinRequest _$SpotJoinRequestFromJson(Map<String, dynamic> json) {
  return SpotJoinRequest(
    password: json['password'] as String,
    receiveCancelledNotifications:
        json['receiveCancelledNotifications'] as bool,
    receiveDelayedNotifications: json['receiveDelayedNotifications'] as bool,
    receiveFinishedNotifications: json['receiveFinishedNotifications'] as bool,
    receiveLiveNotifications: json['receiveLiveNotifications'] as bool,
    receivePreparedNotifications: json['receivePreparedNotifications'] as bool,
  );
}

Map<String, dynamic> _$SpotJoinRequestToJson(SpotJoinRequest instance) =>
    <String, dynamic>{
      'password': instance.password,
      'receiveCancelledNotifications': instance.receiveCancelledNotifications,
      'receiveDelayedNotifications': instance.receiveDelayedNotifications,
      'receiveFinishedNotifications': instance.receiveFinishedNotifications,
      'receiveLiveNotifications': instance.receiveLiveNotifications,
      'receivePreparedNotifications': instance.receivePreparedNotifications,
    };

SpotMembershipManagementRequest _$SpotMembershipManagementRequestFromJson(
    Map<String, dynamic> json) {
  return SpotMembershipManagementRequest(
    receiveCancelledNotifications:
        json['receiveCancelledNotifications'] as bool,
    receiveDelayedNotifications: json['receiveDelayedNotifications'] as bool,
    receiveFinishedNotifications: json['receiveFinishedNotifications'] as bool,
    receiveLiveNotifications: json['receiveLiveNotifications'] as bool,
    receivePreparedNotifications: json['receivePreparedNotifications'] as bool,
  );
}

Map<String, dynamic> _$SpotMembershipManagementRequestToJson(
        SpotMembershipManagementRequest instance) =>
    <String, dynamic>{
      'receiveCancelledNotifications': instance.receiveCancelledNotifications,
      'receiveDelayedNotifications': instance.receiveDelayedNotifications,
      'receiveFinishedNotifications': instance.receiveFinishedNotifications,
      'receiveLiveNotifications': instance.receiveLiveNotifications,
      'receivePreparedNotifications': instance.receivePreparedNotifications,
    };
