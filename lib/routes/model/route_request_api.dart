import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'route_request_api.g.dart';

@JsonSerializable()
class UnpreparedRouteRequest {
  final DateTime date;
  final String description;
  final String name;
  final String profileUid;
  final List<RouteProductRequest> products;
  final List<RouteDropRequest> drops;

  UnpreparedRouteRequest(
      {this.date, this.description, this.name, this.profileUid, this.products, this.drops});

  factory UnpreparedRouteRequest.fromJson(Map<String, dynamic> json) =>
      _$UnpreparedRouteRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UnpreparedRouteRequestToJson(this);
}

@JsonSerializable()
class RouteProductRequest {
  final double amount;
  final bool limitedAmount;
  final double price;
  final int productUid;

  RouteProductRequest({this.amount, this.limitedAmount, this.price, this.productUid});

  factory RouteProductRequest.fromJson(Map<String, dynamic> json) =>
      _$RouteProductRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RouteProductRequestToJson(this);
}

@JsonSerializable()
class RouteDropRequest {
  final String description;
  final DateTime endTime;
  final String name;
  final int spotId;
  final String startTime;

  RouteDropRequest({this.description, this.endTime, this.name, this.spotId, this.startTime});

  factory RouteDropRequest.fromJson(Map<String, dynamic> json) => _$RouteDropRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RouteDropRequestToJson(this);
}

@JsonSerializable()
class RouteStateChangeRequest {
  final String changedProfileUid;
  final RouteStatus newStatus;

  RouteStateChangeRequest({this.changedProfileUid, this.newStatus});

  factory RouteStateChangeRequest.fromJson(Map<String, dynamic> json) =>
      _$RouteStateChangeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RouteStateChangeRequestToJson(this);
}
