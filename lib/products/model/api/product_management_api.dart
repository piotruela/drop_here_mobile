import 'package:drop_here_mobile/common/ui/utils/datetime_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_management_api.g.dart';

@JsonSerializable()
class ProductResponse {
  final int id;
  final String category;
  final String description;
  final String name;
  final double price;
  final List<DropProductResponse> drops;
  final List<ProductCustomizationWrapperResponse> customizationsWrappers;
  final String unit;
  final double unitFraction;

  String get productPrice => "${price.toString()} zł";

  ProductManagementRequest toRequest() => ProductManagementRequest(
      category: category,
      description: description,
      name: name,
      price: price,
      unit: unit,
      unitFraction: unitFraction,
      productCustomizationWrappers: customizationsWrappers?.map((e) => e.toRequest())?.toList() ?? []);

  ProductResponse(
      {this.id,
      this.category,
      this.description,
      this.name,
      this.price,
      this.drops,
      this.customizationsWrappers,
      this.unit,
      this.unitFraction});

  factory ProductResponse.fromJson(Map<String, dynamic> json) => _$ProductResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

@JsonSerializable()
class ProductManagementRequest {
  final String category;
  final String description;
  final String name;
  final double price;
  List<ProductCustomizationWrapperRequest> productCustomizationWrappers;
  final String unit;
  final double unitFraction;

  ProductManagementRequest(
      {this.category,
      this.description,
      this.name,
      this.price,
      this.productCustomizationWrappers,
      this.unit,
      this.unitFraction});

  factory ProductManagementRequest.fromJson(Map<String, dynamic> json) => _$ProductManagementRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ProductManagementRequestToJson(this);

  ProductManagementRequest copyWith(
      {String category,
      String description,
      String name,
      double price,
      List<ProductCustomizationWrapperRequest> productCustomizationWrappers,
      String unit,
      double unitFraction}) {
    return ProductManagementRequest(
      category: category ?? this.category,
      description: description ?? this.description,
      name: name ?? this.name,
      price: price ?? this.price,
      productCustomizationWrappers: productCustomizationWrappers ?? this.productCustomizationWrappers,
      unit: unit ?? this.unit,
      unitFraction: unitFraction ?? this.unitFraction,
    );
  }
}

@JsonSerializable()
class ProductCustomizationWrapperRequest {
  List<ProductCustomizationRequest> customizations;
  String heading;
  CustomizationType type;
  bool required;

  ProductCustomizationWrapperRequest(
      {customizations, this.heading, this.type = CustomizationType.SINGLE, this.required = false})
      : customizations = customizations ?? [];

  factory ProductCustomizationWrapperRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductCustomizationWrapperRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ProductCustomizationWrapperRequestToJson(this);
}

enum CustomizationType { SINGLE, MULTIPLE }

@JsonSerializable()
class ProductCustomizationRequest {
  double price;
  String value;

  ProductCustomizationRequest({this.price, this.value});
  factory ProductCustomizationRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductCustomizationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ProductCustomizationRequestToJson(this);
}

@JsonSerializable()
class Product {
  String category;
  List<ProductCustomizationWrapperResponse> customizationsWrappers;
  String description;
  int id;
  String name;
  double price;
  String unit;
  double unitFraction;

  Product();

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class ProductCustomizationWrapperResponse {
  final int id;
  final List<ProductCustomizationResponse> customizations;
  final String heading;
  final bool required;
  final CustomizationType type;

  ProductCustomizationWrapperRequest toRequest() => ProductCustomizationWrapperRequest(
      heading: heading,
      type: type,
      required: required,
      customizations: customizations?.map((e) => e.toRequest())?.toList() ?? []);

  ProductCustomizationWrapperResponse({this.id, this.customizations, this.heading, this.required, this.type});

  factory ProductCustomizationWrapperResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductCustomizationWrapperResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCustomizationWrapperResponseToJson(this);
}

@JsonSerializable()
class ProductCustomizationResponse {
  final int id;
  final double price;
  final String value;

  ProductCustomizationResponse({this.id, this.price, this.value});

  String get priceWithCurrency => "$price zł";

  factory ProductCustomizationResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductCustomizationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCustomizationResponseToJson(this);

  ProductCustomizationRequest toRequest() => ProductCustomizationRequest(price: price, value: value);
}

@JsonSerializable()
class ProductCategoryResponse {
  final String name;

  ProductCategoryResponse({this.name});

  factory ProductCategoryResponse.fromJson(Map<String, dynamic> json) => _$ProductCategoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProductCategoryResponseToJson(this);
}

@JsonSerializable()
class ProductUnitResponse {
  final String name;
  final bool fractionable;

  ProductUnitResponse({this.name, this.fractionable});

  factory ProductUnitResponse.fromJson(Map<String, dynamic> json) => _$ProductUnitResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProductUnitResponseToJson(this);
}

@JsonSerializable()
class DropProductResponse {
  String uid;
  String name;
  RouteProductProductResponse routeProduct;
  String description;
  DropStatus status;
  DateTime startTime;
  DateTime endTime;
  String spotUid;
  String spotName;
  double spotXCoordinate;
  double spotYCoordinate;
  int spotEstimatedRadiusMeters;
  String spotDescription;

  DropProductResponse(
      {this.uid,
      this.name,
      this.routeProduct,
      this.description,
      this.status,
      this.startTime,
      this.endTime,
      this.spotUid,
      this.spotName,
      this.spotXCoordinate,
      this.spotYCoordinate,
      this.spotEstimatedRadiusMeters,
      this.spotDescription});

  String get durationTime => "${startTime.toTime()} - ${endTime.toTime()}";

  factory DropProductResponse.fromJson(Map<String, dynamic> json) => _$DropProductResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DropProductResponseToJson(this);
}

enum DropStatus { UNPREPARED, PREPARED, DELAYED, CANCELLED, FINISHED, LIVE }

@JsonSerializable()
class RouteProductProductResponse {
  int id;
  double amount;
  bool limitedAmount;
  int originalProductId;
  double price;

  RouteProductProductResponse({this.id, this.amount, this.limitedAmount, this.originalProductId, this.price});

  String get availableAmount => "Available: ${limitedAmount ? amount : "unlimited"}";

  factory RouteProductProductResponse.fromJson(Map<String, dynamic> json) =>
      _$RouteProductProductResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RouteProductProductResponseToJson(this);
}
