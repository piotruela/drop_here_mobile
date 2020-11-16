// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drop_customer_spot_response_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DropCustomerSpotResponse _$DropCustomerSpotResponseFromJson(
    Map<String, dynamic> json) {
  return DropCustomerSpotResponse(
    acceptShipmentsAutomatically: json['acceptShipmentsAutomatically'] as bool,
    description: json['description'] as String,
    endTime: json['endTime'] == null
        ? null
        : DateTime.parse(json['endTime'] as String),
    name: json['name'] as String,
    startTime: json['startTime'] == null
        ? null
        : DateTime.parse(json['startTime'] as String),
    status: _$enumDecodeNullable(_$DropStatusEnumMap, json['status']),
    uid: json['uid'] as String,
  );
}

Map<String, dynamic> _$DropCustomerSpotResponseToJson(
        DropCustomerSpotResponse instance) =>
    <String, dynamic>{
      'acceptShipmentsAutomatically': instance.acceptShipmentsAutomatically,
      'description': instance.description,
      'endTime': instance.endTime?.toIso8601String(),
      'name': instance.name,
      'startTime': instance.startTime?.toIso8601String(),
      'status': _$DropStatusEnumMap[instance.status],
      'uid': instance.uid,
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

const _$DropStatusEnumMap = {
  DropStatus.UNPREPARED: 'UNPREPARED',
  DropStatus.PREPARED: 'PREPARED',
  DropStatus.DELAYED: 'DELAYED',
  DropStatus.CANCELLED: 'CANCELLED',
  DropStatus.FINISHED: 'FINISHED',
  DropStatus.LIVE: 'LIVE',
};

DropDetailedCustomerResponse _$DropDetailedCustomerResponseFromJson(
    Map<String, dynamic> json) {
  return DropDetailedCustomerResponse(
    acceptShipmentsAutomatically: json['acceptShipmentsAutomatically'] as bool,
    description: json['description'] as String,
    endTime: json['endTime'] == null
        ? null
        : DateTime.parse(json['endTime'] as String),
    name: json['name'] as String,
    products: (json['products'] as List)
        ?.map((e) => e == null
            ? null
            : RouteProductRouteResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    profileFirstName: json['profileFirstName'] as String,
    profileLastName: json['profileLastName'] as String,
    profileUid: json['profileUid'] as String,
    spot: json['spot'] == null
        ? null
        : SpotBaseCustomerResponse.fromJson(
            json['spot'] as Map<String, dynamic>),
    startTime: json['startTime'] == null
        ? null
        : DateTime.parse(json['startTime'] as String),
    status: _$enumDecodeNullable(_$DropStatusEnumMap, json['status']),
    streamingPosition: json['streamingPosition'] as bool,
    uid: json['uid'] as String,
  );
}

Map<String, dynamic> _$DropDetailedCustomerResponseToJson(
        DropDetailedCustomerResponse instance) =>
    <String, dynamic>{
      'acceptShipmentsAutomatically': instance.acceptShipmentsAutomatically,
      'description': instance.description,
      'endTime': instance.endTime?.toIso8601String(),
      'name': instance.name,
      'products': instance.products,
      'profileFirstName': instance.profileFirstName,
      'profileLastName': instance.profileLastName,
      'profileUid': instance.profileUid,
      'spot': instance.spot,
      'startTime': instance.startTime?.toIso8601String(),
      'status': _$DropStatusEnumMap[instance.status],
      'streamingPosition': instance.streamingPosition,
      'uid': instance.uid,
    };
