import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:drop_here_mobile/spots/model/api/spot_user_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drop_customer_spot_response_api.g.dart';

@JsonSerializable()
class DropCustomerSpotResponse {
  final bool acceptShipmentsAutomatically;
  final String description;
  final DateTime endTime;
  final String name;
  final DateTime startTime;
  final DropStatus status;
  final String uid;

  DropCustomerSpotResponse(
      {this.acceptShipmentsAutomatically,
      this.description,
      this.endTime,
      this.name,
      this.startTime,
      this.status,
      this.uid});

  factory DropCustomerSpotResponse.fromJson(Map<String, dynamic> json) => _$DropCustomerSpotResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DropCustomerSpotResponseToJson(this);
}

@JsonSerializable()
class DropDetailedCustomerResponse {
  bool acceptShipmentsAutomatically;
  String description;
  DateTime endTime;
  String name;
  List<RouteProductRouteResponse> products;
  String profileFirstName;
  String profileLastName;
  String profileUid;
  SpotBaseCustomerResponse spot;
  DateTime startTime;
  DropStatus status;
  bool streamingPosition;
  String uid;

  DropDetailedCustomerResponse(
      {this.acceptShipmentsAutomatically,
      this.description,
      this.endTime,
      this.name,
      this.products,
      this.profileFirstName,
      this.profileLastName,
      this.profileUid,
      this.spot,
      this.startTime,
      this.status,
      this.streamingPosition,
      this.uid});

  factory DropDetailedCustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$DropDetailedCustomerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DropDetailedCustomerResponseToJson(this);

  String get sellerFullName => "$profileFirstName $profileLastName";

  bool get shipmentsAvailable =>
      status == DropStatus.PREPARED || status == DropStatus.DELAYED || status == DropStatus.LIVE;
}
