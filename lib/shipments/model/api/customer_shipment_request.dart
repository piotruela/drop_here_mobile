import 'package:json_annotation/json_annotation.dart';

part 'customer_shipment_request.g.dart';

@JsonSerializable()
class ShipmentCustomerSubmissionRequest {
  String comment;
  List<ShipmentProductRequest> products;

  ShipmentCustomerSubmissionRequest({this.comment, this.products});

  factory ShipmentCustomerSubmissionRequest.fromJson(Map<String, dynamic> json) =>
      _$ShipmentCustomerSubmissionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentCustomerSubmissionRequestToJson(this);
}

@JsonSerializable()
class ShipmentProductRequest {
  List<ShipmentCustomizationRequest> customizations;
  double quantity;
  int routeProductId;

  ShipmentProductRequest({this.customizations, this.quantity, this.routeProductId});

  factory ShipmentProductRequest.fromJson(Map<String, dynamic> json) => _$ShipmentProductRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentProductRequestToJson(this);
}

@JsonSerializable()
class ShipmentCustomizationRequest {
  int id;

  ShipmentCustomizationRequest({this.id});

  factory ShipmentCustomizationRequest.fromJson(Map<String, dynamic> json) =>
      _$ShipmentCustomizationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentCustomizationRequestToJson(this);
}

@JsonSerializable()
class ShipmentCustomerDecisionRequest {
  String comment;
  CustomerDecision customerDecision;

  ShipmentCustomerDecisionRequest({this.comment, this.customerDecision});

  factory ShipmentCustomerDecisionRequest.fromJson(Map<String, dynamic> json) =>
      _$ShipmentCustomerDecisionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentCustomerDecisionRequestToJson(this);
}

enum CustomerDecision { CANCEL }
