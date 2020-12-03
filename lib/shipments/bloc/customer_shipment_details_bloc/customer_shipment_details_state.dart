part of 'customer_shipment_details_bloc.dart';

class CustomerShipmentDetailsState extends Equatable {
  final CustomerShipmentDetailsStateType type;
  final ShipmentResponse shipment;

  CustomerShipmentDetailsState({this.type, this.shipment});

  @override
  List<Object> get props => [type, shipment];
}

enum CustomerShipmentDetailsStateType { loading, error, shipment_fetched, status_changed }
