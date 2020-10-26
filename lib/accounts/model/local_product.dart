import 'package:drop_here_mobile/products/model/api/product_management_api.dart';

class LocalProduct {
  String _category;
  String _name;
  String _description;
  String _unit;
  double _unitFraction;
  double price;
  int _id;
  double amount;
  bool limitedAmount;

  LocalProduct(ProductResponse productResponse) {
    this._category = productResponse.category;
    this._name = productResponse.name;
    this._description = productResponse.description;
    this._unit = productResponse.unit;
    this._unitFraction = productResponse.unitFraction;
    this.price = productResponse.price;
    this._id = productResponse.id;
  }

  String get category => _category;

  int get id => _id;

  double get unitFraction => _unitFraction;

  String get unit => _unit;

  String get description => _description;

  String get name => _name;
}
