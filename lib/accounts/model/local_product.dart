import 'package:drop_here_mobile/products/model/api/product_management_api.dart';

class LocalProduct extends ProductResponse {
  String category;
  String name;
  String description;
  String unit;
  double unitFraction;
  double price;
  int id;
  double amount;
  bool limitedAmount;

  LocalProduct(ProductResponse productResponse) {
    this.category = productResponse.category;
    this.name = productResponse.name;
    this.description = productResponse.description;
    this.unit = productResponse.unit;
    this.unitFraction = productResponse.unitFraction;
    this.price = productResponse.price;
    this.id = productResponse.id;
  }

  @override
  bool operator ==(Object other) {
    return this.name == LocalProduct(other).name;
  }

  @override
  int get hashCode => name.hashCode;

  // String get category => _category;
  //
  // int get id => _id;
  //
  // double get unitFraction => _unitFraction;
  //
  // String get unit => _unit;
  //
  // String get description => _description;
  //
  // String get name => _name;
}
