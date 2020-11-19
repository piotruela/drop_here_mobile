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

  AddProduct({this.productRequest});

  @override
  List<Object> get props => [productRequest];
}

class RemoveProduct extends CustomerShipmentEvent {
  final int productId;

  RemoveProduct({this.productId});

  @override
  List<Object> get props => [productId];
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
