import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'route_request_api.g.dart';

@JsonSerializable()
class UnpreparedRouteRequest {
  final bool acceptShipmentsAutomatically;
  final String date;
  final String description;
  final String name;
  final String profileUid;
  final List<RouteProductRequest> products;
  final List<RouteDropRequest> drops;

  UnpreparedRouteRequest(
      {this.acceptShipmentsAutomatically,
      this.date,
      this.description,
      this.name,
      this.profileUid,
      this.products,
      this.drops});

  factory UnpreparedRouteRequest.fromJson(Map<String, dynamic> json) => _$UnpreparedRouteRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UnpreparedRouteRequestToJson(this);

  UnpreparedRouteRequest copyWith({
    String date,
    String description,
    String name,
    String profileUid,
    List<RouteProductRequest> products,
    List<RouteDropRequest> drops,
    bool sellerNull = false,
    bool autoAccept,
  }) {
    return UnpreparedRouteRequest(
        date: date ?? this.date,
        description: description ?? this.description,
        name: name ?? this.name,
        profileUid: sellerNull ? null : profileUid ?? this.profileUid,
        products: products ?? this.products,
        drops: drops ?? this.drops,
        acceptShipmentsAutomatically: autoAccept ?? this.acceptShipmentsAutomatically);
  }
}

@JsonSerializable()
class RouteProductRequest {
  double amount;
  bool limitedAmount;
  double price;
  int productId;

  RouteProductRequest({this.amount, this.limitedAmount = true, this.price, this.productId});

  factory RouteProductRequest.fromJson(Map<String, dynamic> json) => _$RouteProductRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RouteProductRequestToJson(this);

  RouteProductRequest copyWith({
    double amount,
    bool limitedAmount,
    double price,
    int productUid,
  }) {
    return RouteProductRequest(
      amount: amount ?? this.amount,
      limitedAmount: limitedAmount ?? this.limitedAmount,
      price: price ?? this.price,
      productId: productUid ?? this.productId,
    );
  }

  String get productAmountToString => "Amount:  ${!limitedAmount ? "unlimited" : amount}";
}

@JsonSerializable()
class RouteDropRequest {
  final String description;
  final String endTime;
  final String name;
  int spotId;
  final String startTime;

  RouteDropRequest({this.description, this.endTime, this.name, this.spotId, this.startTime});

  factory RouteDropRequest.fromJson(Map<String, dynamic> json) => _$RouteDropRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RouteDropRequestToJson(this);

  RouteDropRequest copyWith({
    String description,
    String endTime,
    String name,
    int spotId,
    String startTime,
    bool endTimeNull = false,
  }) {
    return RouteDropRequest(
        description: description ?? this.description,
        endTime: endTimeNull ? null : endTime ?? this.endTime,
        name: name ?? this.name,
        spotId: spotId ?? this.spotId,
        startTime: startTime ?? this.startTime);
  }
}

@JsonSerializable()
class RouteStateChangeRequest {
  final String changedProfileUid;
  final RouteStatus newStatus;

  RouteStateChangeRequest({this.changedProfileUid, this.newStatus});

  factory RouteStateChangeRequest.fromJson(Map<String, dynamic> json) => _$RouteStateChangeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RouteStateChangeRequestToJson(this);
}

@JsonSerializable()
class DropManagementRequest {
  DropStatus newStatus;
  int delayByMinutes;

  DropManagementRequest({this.newStatus, this.delayByMinutes});

  factory DropManagementRequest.fromJson(Map<String, dynamic> json) => _$DropManagementRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DropManagementRequestToJson(this);
}
