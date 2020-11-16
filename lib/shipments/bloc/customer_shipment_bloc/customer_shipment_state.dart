part of 'customer_shipment_bloc.dart';

class CustomerShipmentState extends Equatable {
  final CustomerShipmentStateType type;
  final DropDetailedCustomerResponse drop;
  final List<ShipmentProductRequest> selectedProducts;
  final String comment;

  CustomerShipmentState({this.type, this.drop, this.selectedProducts, this.comment});

  @override
  List<Object> get props => [type, drop, selectedProducts, comment];
}

enum CustomerShipmentStateType { products_fetched, products_changed, loading, comment_changed, sent }
