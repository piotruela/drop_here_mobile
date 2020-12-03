import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:drop_here_mobile/shipments/model/api/company_shipment_response.dart';
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

@JsonSerializable()
class CustomerShipmentRequest {
  final int offset;
  final int pageNumber;
  final int pageSize;
  final bool paged;
  final bool sortSorted;
  final bool sortUnsorted;
  final ShipmentStatus status;
  final bool unpaged;

  CustomerShipmentRequest(
      {this.offset,
      this.pageNumber,
      this.pageSize,
      this.paged,
      this.sortSorted,
      this.sortUnsorted,
      this.unpaged,
      this.status});

  String toQueryParams() {
    return "&offset=${offset ?? ''}"
        "&pageNumber=${pageNumber ?? ''}"
        "&pageSize=${pageSize ?? ''}"
        "&paged=${paged ?? ''}"
        "&sort.sorted=${sortSorted ?? ''}"
        "&sort.unsorted=${sortUnsorted ?? ''}"
        "&status=${status != null ? describeEnum(status) : ''}"
        "&unpaged=${unpaged ?? ''}";
  }

  factory CustomerShipmentRequest.fromJson(Map<String, dynamic> json) => _$CustomerShipmentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerShipmentRequestToJson(this);
}

enum CustomerDecision { CANCEL }
