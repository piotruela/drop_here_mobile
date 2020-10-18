// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_response_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutePage _$RoutePageFromJson(Map<String, dynamic> json) {
  return RoutePage()
    ..content = (json['content'] as List)
        ?.map((e) => e == null
            ? null
            : RouteShortResponse.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$RoutePageToJson(RoutePage instance) => <String, dynamic>{
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

RouteShortResponse _$RouteShortResponseFromJson(Map<String, dynamic> json) {
  return RouteShortResponse(
    dropsAmount: json['dropsAmount'] as int,
    id: json['id'] as int,
    name: json['name'] as String,
    productsAmount: json['productsAmount'] as int,
    profileFirstName: json['profileFirstName'] as String,
    profileLastName: json['profileLastName'] as String,
    profileUid: json['profileUid'] as String,
  );
}

Map<String, dynamic> _$RouteShortResponseToJson(RouteShortResponse instance) =>
    <String, dynamic>{
      'dropsAmount': instance.dropsAmount,
      'id': instance.id,
      'name': instance.name,
      'productsAmount': instance.productsAmount,
      'profileFirstName': instance.profileFirstName,
      'profileLastName': instance.profileLastName,
      'profileUid': instance.profileUid,
    };

RouteResponse _$RouteResponseFromJson(Map<String, dynamic> json) {
  return RouteResponse(
    description: json['description'] as String,
    drops: (json['drops'] as List)
        ?.map((e) => e == null
            ? null
            : DropRouteResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    dropsAmount: json['dropsAmount'] as int,
    id: json['id'] as int,
    name: json['name'] as String,
    products: (json['products'] as List)
        ?.map((e) => e == null
            ? null
            : RouteProductRouteResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    productsAmount: json['productsAmount'] as int,
    profileFirstName: json['profileFirstName'] as String,
    profileLastName: json['profileLastName'] as String,
    profileUid: json['profileUid'] as String,
    routeDate: json['routeDate'] == null
        ? null
        : DateTime.parse(json['routeDate'] as String),
    status: _$enumDecodeNullable(_$RouteStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$RouteResponseToJson(RouteResponse instance) =>
    <String, dynamic>{
      'description': instance.description,
      'drops': instance.drops,
      'dropsAmount': instance.dropsAmount,
      'id': instance.id,
      'name': instance.name,
      'products': instance.products,
      'productsAmount': instance.productsAmount,
      'profileFirstName': instance.profileFirstName,
      'profileLastName': instance.profileLastName,
      'profileUid': instance.profileUid,
      'routeDate': instance.routeDate?.toIso8601String(),
      'status': _$RouteStatusEnumMap[instance.status],
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
  RouteStatus.ONGOING: 'ONGOING',
  RouteStatus.FINISHED: 'FINISHED',
};

DropRouteResponse _$DropRouteResponseFromJson(Map<String, dynamic> json) {
  return DropRouteResponse(
    description: json['description'] as String,
    endTime: json['endTime'] == null
        ? null
        : DateTime.parse(json['endTime'] as String),
    name: json['name'] as String,
    spot: json['spot'] == null
        ? null
        : SpotCompanyResponse.fromJson(json['spot'] as Map<String, dynamic>),
    startTime: json['startTime'] == null
        ? null
        : DateTime.parse(json['startTime'] as String),
    status: _$enumDecodeNullable(_$DropStatusEnumMap, json['status']),
    uid: json['uid'] as String,
  );
}

Map<String, dynamic> _$DropRouteResponseToJson(DropRouteResponse instance) =>
    <String, dynamic>{
      'description': instance.description,
      'endTime': instance.endTime?.toIso8601String(),
      'name': instance.name,
      'spot': instance.spot,
      'startTime': instance.startTime?.toIso8601String(),
      'status': _$DropStatusEnumMap[instance.status],
      'uid': instance.uid,
    };

const _$DropStatusEnumMap = {
  DropStatus.UNPREPARED: 'UNPREPARED',
  DropStatus.PREPARED: 'PREPARED',
  DropStatus.DELAYED: 'DELAYED',
  DropStatus.CANCELLED: 'CANCELLED',
  DropStatus.FINISHED: 'FINISHED',
  DropStatus.LIVE: 'LIVE',
};

RouteProductRouteResponse _$RouteProductRouteResponseFromJson(
    Map<String, dynamic> json) {
  return RouteProductRouteResponse(
    amount: (json['amount'] as num)?.toDouble(),
    id: json['id'] as int,
    limitedAmount: json['limitedAmount'] as bool,
    price: (json['price'] as num)?.toDouble(),
    productResponse: json['productResponse'] == null
        ? null
        : ProductResponse.fromJson(
            json['productResponse'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RouteProductRouteResponseToJson(
        RouteProductRouteResponse instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'id': instance.id,
      'limitedAmount': instance.limitedAmount,
      'price': instance.price,
      'productResponse': instance.productResponse,
    };
