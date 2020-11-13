import 'package:drop_here_mobile/routes/model/route_response_api.dart';
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
