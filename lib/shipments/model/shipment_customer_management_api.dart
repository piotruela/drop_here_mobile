import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ShipmentCustomerSubmissionRequest {
  String comment;
  List<ShipmentProductRequest> products;

  ShipmentCustomerSubmissionRequest({this.comment, this.products});

  ShipmentCustomerSubmissionRequest.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    if (json['products'] != null) {
      products = new List<ShipmentProductRequest>();
      json['products'].forEach((v) {
        products.add(new ShipmentProductRequest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@JsonSerializable()
class ShipmentProductRequest {
  List<ShipmentCustomizationRequest> customizations;
  double quantity;
  int routeProductId;

  ShipmentProductRequest({this.customizations, this.quantity, this.routeProductId});

  ShipmentProductRequest.fromJson(Map<String, dynamic> json) {
    if (json['customizations'] != null) {
      customizations = new List<ShipmentCustomizationRequest>();
      json['customizations'].forEach((v) {
        customizations.add(new ShipmentCustomizationRequest.fromJson(v));
      });
    }
    quantity = json['quantity'];
    routeProductId = json['routeProductId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customizations != null) {
      data['customizations'] = this.customizations.map((v) => v.toJson()).toList();
    }
    data['quantity'] = this.quantity;
    data['routeProductId'] = this.routeProductId;
    return data;
  }
}

@JsonSerializable()
class ShipmentCustomizationRequest {
  int id;

  ShipmentCustomizationRequest({this.id});

  ShipmentCustomizationRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
