import 'package:drop_here_mobile/common/ui/utils/datetime_utils.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/products/model/api/page_api.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/routes/model/route_request_api.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'route_response_api.g.dart';

@JsonSerializable()
class RoutePage {
  List<RouteShortResponse> content;
  bool empty;
  bool first;
  bool last;
  int number;
  int numberOfElements;
  Pageable pageable;
  int size;
  Sort sort;
  int totalElements;
  int totalPages;

  RoutePage();

  factory RoutePage.fromJson(Map<String, dynamic> json) => _$RoutePageFromJson(json);
  Map<String, dynamic> toJson() => _$RoutePageToJson(this);
}

@JsonSerializable()
class RouteShortResponse {
  final int dropsAmount;
  final int id;
  final String name;
  final int productsAmount;
  final String profileFirstName;
  final String profileLastName;
  final String profileUid;
  final RouteStatus status;

  RouteShortResponse(
      {this.dropsAmount,
      this.id,
      this.name,
      this.productsAmount,
      this.profileFirstName,
      this.profileLastName,
      this.profileUid,
      this.status});

  factory RouteShortResponse.fromJson(Map<String, dynamic> json) => _$RouteShortResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RouteShortResponseToJson(this);
}

@JsonSerializable()
class RouteResponse {
  final bool acceptShipmentsAutomatically;
  final String description;
  final List<DropRouteResponse> drops;
  final int dropsAmount;
  final int id;
  final String name;
  final List<RouteProductRouteResponse> products;
  final int productsAmount;
  final String profileFirstName;
  final String profileLastName;
  final String profileUid;
  final String routeDate;
  final RouteStatus status;

  RouteResponse(
      {this.acceptShipmentsAutomatically,
      this.description,
      this.drops,
      this.dropsAmount,
      this.id,
      this.name,
      this.products,
      this.productsAmount,
      this.profileFirstName,
      this.profileLastName,
      this.profileUid,
      this.routeDate,
      this.status});

  factory RouteResponse.fromJson(Map<String, dynamic> json) => _$RouteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RouteResponseToJson(this);

  String get sellerFullName => "$profileFirstName $profileLastName";

  UnpreparedRouteRequest get toRouteRequest => UnpreparedRouteRequest(
      acceptShipmentsAutomatically: acceptShipmentsAutomatically,
      date: routeDate,
      description: description,
      name: name,
      profileUid: profileUid,
      products: products.map((e) => e.toRouteProductRequest).toList(),
      drops: drops.map((e) => e.toRouteDropRequest).toList());
}

@JsonSerializable()
class DropRouteResponse {
  final String description;
  final DateTime endTime;
  final String name;
  final SpotCompanyResponse spot;
  final DateTime startTime;
  final DropStatus status;
  final String uid;

  DropRouteResponse({this.description, this.endTime, this.name, this.spot, this.startTime, this.status, this.uid});

  factory DropRouteResponse.fromJson(Map<String, dynamic> json) => _$DropRouteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DropRouteResponseToJson(this);

  RouteDropRequest get toRouteDropRequest => RouteDropRequest(
      description: description, startTime: startTime.toTime(), endTime: endTime.toTime(), spotId: spot.id, name: name);
}

@JsonSerializable()
class RouteProductRouteResponse {
  final double amount;
  final int id;
  final bool limitedAmount;
  final double price;
  final ProductResponse productResponse;

  RouteProductRouteResponse({this.amount, this.id, this.limitedAmount, this.price, this.productResponse});

  factory RouteProductRouteResponse.fromJson(Map<String, dynamic> json) => _$RouteProductRouteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RouteProductRouteResponseToJson(this);

  String toPricePerUnit(LocaleBundle locale) {
    return price.toString() + locale.currency + '/' + productResponse.unit;
  }

  RouteProductRequest get toRouteProductRequest =>
      RouteProductRequest(amount: amount, limitedAmount: limitedAmount, price: price, productId: productResponse.id);
}

enum RouteStatus { UNPREPARED, PREPARED, ONGOING, FINISHED }

enum DropStatus { UNPREPARED, PREPARED, DELAYED, CANCELLED, FINISHED, LIVE }
