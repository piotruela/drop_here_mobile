import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:flutter/material.dart';
import 'package:quiver/core.dart';

class LocalProduct extends ProductResponse {
  String category;
  String name;
  String description;
  String unit;
  double unitFraction;
  double price;
  int id;
  double amount;
  bool unlimited = false;
  final Image photo;

  LocalProduct(ProductResponse productResponse, {this.photo}) {
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
    LocalProduct o = LocalProduct(other);
    return this.name == o.name &&
        this.category == o.category &&
        this.id == o.id &&
        this.description == o.description &&
        this.unit == o.unit &&
        this.unitFraction == o.unitFraction;
  }

  @override
  int get hashCode => hash4(name, id, category, description);
}
