import 'package:drop_here_mobile/products/model/api/page_api.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
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
  DateTime rejectedAt;
  ShipmentStatus status;
  double summarizedAmount;

  ShipmentResponse();

  factory ShipmentResponse.fromJson(Map<String, dynamic> json) => _$ShipmentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentResponseToJson(this);
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

  ShipmentProductResponse();

  factory ShipmentProductResponse.fromJson(Map<String, dynamic> json) => _$ShipmentProductResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentProductResponseToJson(this);
}

@JsonSerializable()
class ShipmentProductCustomizationResponse {
  double customizationPrice;
  String customizationValue;
  String wrapperHeading;
  int wrapperId;
  CustomizationType wrapperType;

  ShipmentProductCustomizationResponse();

  factory ShipmentProductCustomizationResponse.fromJson(Map<String, dynamic> json) =>
      _$ShipmentProductCustomizationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentProductCustomizationResponseToJson(this);
}

enum ShipmentStatus { PLACED, ACCEPTED, CANCEL_REQUESTED, CANCELLED, DELIVERED, REJECTED }
