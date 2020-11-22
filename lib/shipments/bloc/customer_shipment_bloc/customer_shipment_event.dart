part of 'customer_shipment_bloc.dart';

abstract class CustomerShipmentEvent extends Equatable {
  const CustomerShipmentEvent();
}

class InitializeCreateOrder extends CustomerShipmentEvent {
  final DropDetailedCustomerResponse drop;

  InitializeCreateOrder({this.drop});

  @override
  List<Object> get props => [drop];
}

class InitializeEditOrder extends CustomerShipmentEvent {
  final String dropUid;
  final ShipmentResponse order;

  InitializeEditOrder({this.dropUid, this.order});

  @override
  List<Object> get props => [dropUid, order];
}

class AddProduct extends CustomerShipmentEvent {
  final ShipmentProductRequest productRequest;
  final double amount;

  AddProduct({this.productRequest, this.amount});

  @override
  List<Object> get props => [productRequest, amount];
}

class RemoveProduct extends CustomerShipmentEvent {
  final ShipmentProductRequest product;
  final double amount;

  RemoveProduct({this.product, this.amount});

  @override
  List<Object> get props => [product, amount];
}

class CommentChanged extends CustomerShipmentEvent {
  final String comment;

  CommentChanged({this.comment});

  @override
  List<Object> get props => [comment];
}

class SubmitForm extends CustomerShipmentEvent {
  final String companyUid;
  final String dropUid;
  final String shipmentId;

  SubmitForm({this.companyUid, this.dropUid, this.shipmentId});

  @override
  List<Object> get props => [companyUid, dropUid, shipmentId];
}
