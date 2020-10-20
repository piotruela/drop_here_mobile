import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:flutter/material.dart';

class ProductWithPhoto extends ProductResponse {
  final Image photo;

  ProductWithPhoto(
      {this.photo,
      int id,
      String category,
      String description,
      String name,
      double price,
      List<ProductCustomizationWrapperRequest> productCustomizationWrappers,
      String unit,
      double unitFraction})
      : super(
            id: id,
            category: category,
            description: description,
            name: name,
            price: price,
            productCustomizationWrappers: productCustomizationWrappers,
            unit: unit,
            unitFraction: unitFraction);
}
