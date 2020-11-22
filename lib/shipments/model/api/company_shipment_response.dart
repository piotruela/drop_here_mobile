import 'package:drop_here_mobile/products/model/api/page_api.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/shipments/model/api/customer_shipment_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_shipment_response.g.dart';

@JsonSerializable()
class CompanyShipmentsPage {
  List<ShipmentResponse> content;
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

  CompanyShipmentsPage();

  factory CompanyShipmentsPage.fromJson(Map<String, dynamic> json) => _$CompanyShipmentsPageFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyShipmentsPageToJson(this);
}

@JsonSerializable()
class ShipmentResponse {
  DateTime acceptedAt;
  DateTime cancelRequestedAt;
  DateTime cancelledAt;
  String companyComment;
  String companyName;
  String companyUid;
  DateTime compromiseAcceptedAt;
  DateTime createdAt;
  String customerComment;
  String customerFirstName;
  int customerId;
  String customerLastName;
  DateTime deliveredAt;
  String dropUid;
  int id;
  DateTime placedAt;
  List<ShipmentProductResponse> products;
  List<ShipmentFlowResponse> flows;
  DateTime rejectedAt;
  ShipmentStatus status;
  double summarizedAmount;

  ShipmentResponse(
      {this.acceptedAt,
      this.cancelRequestedAt,
      this.cancelledAt,
      this.companyComment,
      this.companyName,
      this.companyUid,
      this.compromiseAcceptedAt,
      this.createdAt,
      this.customerComment,
      this.customerFirstName,
      this.customerId,
      this.customerLastName,
      this.deliveredAt,
      this.dropUid,
      this.id,
      this.placedAt,
      this.flows,
      this.products,
      this.rejectedAt,
      this.status,
      this.summarizedAmount});

  factory ShipmentResponse.fromJson(Map<String, dynamic> json) => _$ShipmentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentResponseToJson(this);

  String get customerFullName => "$customerFirstName $customerLastName";
}

@JsonSerializable()
class ShipmentProductResponse {
  List<ShipmentProductCustomizationResponse> customizations;
  int id;
  String productDescription;
  int productId;
  String productName;
  double quantity;
  double summarizedPrice;
  double unitCustomizationsPrice;
  double unitPrice;
  double unitSummarizedPrice;

  ShipmentProductResponse(
      {this.customizations,
      this.id,
      this.productDescription,
      this.productId,
      this.productName,
      this.quantity,
      this.summarizedPrice,
      this.unitCustomizationsPrice,
      this.unitPrice,
      this.unitSummarizedPrice});

  factory ShipmentProductResponse.fromJson(Map<String, dynamic> json) => _$ShipmentProductResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentProductResponseToJson(this);

  ShipmentProductRequest get toRequest => ShipmentProductRequest(
      quantity: quantity,
      routeProductId: productId,
      customizations: customizations.map((e) => ShipmentCustomizationRequest(id: e.id)).toList());
}

@JsonSerializable()
class ShipmentProductCustomizationResponse {
  double customizationPrice;
  String customizationValue;
  String wrapperHeading;
  int id;
  int wrapperId;
  CustomizationType wrapperType;

  ShipmentProductCustomizationResponse(
      {this.customizationPrice, this.customizationValue, this.wrapperHeading, this.wrapperId, this.wrapperType});

  factory ShipmentProductCustomizationResponse.fromJson(Map<String, dynamic> json) =>
      _$ShipmentProductCustomizationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentProductCustomizationResponseToJson(this);
}

@JsonSerializable()
class ShipmentFlowResponse {
  DateTime createdAt;
  ShipmentStatus status;

  ShipmentFlowResponse({this.createdAt, this.status});

  factory ShipmentFlowResponse.fromJson(Map<String, dynamic> json) => _$ShipmentFlowResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentFlowResponseToJson(this);
}

enum ShipmentStatus { PLACED, ACCEPTED, CANCEL_REQUESTED, CANCELLED, DELIVERED, REJECTED }
