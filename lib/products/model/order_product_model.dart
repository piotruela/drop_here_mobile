import 'package:drop_here_mobile/shipments/model/shipment_customer_management_api.dart';
import 'package:flutter/material.dart';

import 'api/product_management_api.dart';

class OrderProductModel {
  final ShipmentProductRequest shipmentProduct;
  final double amount;
  final double fullPrice;
  final bool unlimited;
  final Image photo;
  final ProductResponse productResponse;

  String get pricePerAmount => '${productResponse.price} zł/${productResponse.unit}';

  OrderProductModel({this.amount, this.fullPrice, this.unlimited, this.photo, this.productResponse})
      : shipmentProduct = ShipmentProductRequest(customizations: []);
}
