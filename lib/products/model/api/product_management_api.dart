import 'package:json_annotation/json_annotation.dart';

part 'product_management_api.g.dart';

@JsonSerializable()
class ProductResponse extends ProductManagementRequest {
  final int id;
  final String category;
  final String description;
  final String name;
  final double price;
  final List<ProductCustomizationWrapperRequest> productCustomizationWrappers;
  final String unit;
  final double unitFraction;

  ProductResponse(
      {this.id,
      this.category,
      this.description,
      this.name,
      this.price,
      this.productCustomizationWrappers,
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
  final List<ProductCustomizationWrapperRequest> productCustomizationWrappers;
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

  factory ProductManagementRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductManagementRequestFromJson(json);
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
      productCustomizationWrappers:
          productCustomizationWrappers ?? this.productCustomizationWrappers,
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

  ProductCustomizationWrapperRequest copyWith(
      {List<ProductCustomizationRequest> customizations, String heading, String type}) {
    return ProductCustomizationWrapperRequest(
        customizations: customizations ?? this.customizations,
        heading: heading ?? this.heading,
        type: type ?? this.type);
  }
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

  ProductCustomizationRequest copyWith({double price, String value}) {
    return ProductCustomizationRequest(price: price ?? this.price, value: value ?? this.value);
  }
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
  final List<ProductCustomizationResponse> customizations;
  final String heading;
  final String type;
  ProductCustomizationWrapperResponse({this.customizations, this.heading, this.type});
  factory ProductCustomizationWrapperResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductCustomizationWrapperResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProductCustomizationWrapperResponseToJson(this);

  ProductCustomizationWrapperResponse copyWith(
      {List<ProductCustomizationWrapperResponse> customizations, String heading, String type}) {
    return ProductCustomizationWrapperResponse(
        customizations: customizations ?? this.customizations,
        heading: heading ?? this.heading,
        type: type ?? this.type);
  }
}

@JsonSerializable()
class ProductCustomizationResponse {
  final double price;
  final String value;

  ProductCustomizationResponse({this.price, this.value});

  factory ProductCustomizationResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductCustomizationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCustomizationResponseToJson(this);

  ProductCustomizationResponse copyWith({double price, String value}) {
    return ProductCustomizationResponse(price: price ?? this.price, value: value ?? this.value);
  }
}

@JsonSerializable()
class ProductCategoryResponse {
  final String name;

  ProductCategoryResponse({this.name});

  factory ProductCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProductCategoryResponseToJson(this);
}

@JsonSerializable()
class ProductUnitResponse {
  final String name;
  final bool fractionable;

  ProductUnitResponse({this.name, this.fractionable});

  factory ProductUnitResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductUnitResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProductUnitResponseToJson(this);
}
