// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_request_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnpreparedRouteRequest _$UnpreparedRouteRequestFromJson(
    Map<String, dynamic> json) {
  return UnpreparedRouteRequest(
    acceptShipmentsAutomatically: json['acceptShipmentsAutomatically'] as bool,
    date: json['date'] as String,
    description: json['description'] as String,
    name: json['name'] as String,
    profileUid: json['profileUid'] as String,
    products: (json['products'] as List)
        ?.map((e) => e == null
            ? null
            : RouteProductRequest.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    drops: (json['drops'] as List)
        ?.map((e) => e == null
            ? null
            : RouteDropRequest.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UnpreparedRouteRequestToJson(
        UnpreparedRouteRequest instance) =>
    <String, dynamic>{
      'acceptShipmentsAutomatically': instance.acceptShipmentsAutomatically,
      'date': instance.date,
      'description': instance.description,
      'name': instance.name,
      'profileUid': instance.profileUid,
      'products': instance.products,
      'drops': instance.drops,
    };

RouteProductRequest _$RouteProductRequestFromJson(Map<String, dynamic> json) {
  return RouteProductRequest(
    amount: (json['amount'] as num)?.toDouble(),
    limitedAmount: json['limitedAmount'] as bool,
    price: (json['price'] as num)?.toDouble(),
    productId: json['productId'] as int,
  );
}

Map<String, dynamic> _$RouteProductRequestToJson(
        RouteProductRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'limitedAmount': instance.limitedAmount,
      'price': instance.price,
      'productId': instance.productId,
    };

RouteDropRequest _$RouteDropRequestFromJson(Map<String, dynamic> json) {
  return RouteDropRequest(
    description: json['description'] as String,
    endTime: json['endTime'] as String,
    name: json['name'] as String,
    spotId: json['spotId'] as int,
    startTime: json['startTime'] as String,
  );
}

Map<String, dynamic> _$RouteDropRequestToJson(RouteDropRequest instance) =>
    <String, dynamic>{
      'description': instance.description,
      'endTime': instance.endTime,
      'name': instance.name,
      'spotId': instance.spotId,
      'startTime': instance.startTime,
    };

RouteStateChangeRequest _$RouteStateChangeRequestFromJson(
    Map<String, dynamic> json) {
  return RouteStateChangeRequest(
    changedProfileUid: json['changedProfileUid'] as String,
    newStatus: _$enumDecodeNullable(_$RouteStatusEnumMap, json['newStatus']),
  );
}

Map<String, dynamic> _$RouteStateChangeRequestToJson(
        RouteStateChangeRequest instance) =>
    <String, dynamic>{
      'changedProfileUid': instance.changedProfileUid,
      'newStatus': _$RouteStatusEnumMap[instance.newStatus],
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

const _$RouteStatusEnumMap = {
  RouteStatus.UNPREPARED: 'UNPREPARED',
  RouteStatus.PREPARED: 'PREPARED',
  RouteStatus.CANCELLED: 'CANCELLED',
  RouteStatus.ONGOING: 'ONGOING',
  RouteStatus.FINISHED: 'FINISHED',
};

DropManagementRequest _$DropManagementRequestFromJson(
    Map<String, dynamic> json) {
  return DropManagementRequest(
    newStatus: _$enumDecodeNullable(_$DropStatusEnumMap, json['newStatus']),
    delayByMinutes: json['delayByMinutes'] as int,
  );
}

Map<String, dynamic> _$DropManagementRequestToJson(
        DropManagementRequest instance) =>
    <String, dynamic>{
      'newStatus': _$DropStatusEnumMap[instance.newStatus],
      'delayByMinutes': instance.delayByMinutes,
    };

const _$DropStatusEnumMap = {
  DropStatus.UNPREPARED: 'UNPREPARED',
  DropStatus.PREPARED: 'PREPARED',
  DropStatus.DELAYED: 'DELAYED',
  DropStatus.CANCELLED: 'CANCELLED',
  DropStatus.FINISHED: 'FINISHED',
  DropStatus.LIVE: 'LIVE',
};
