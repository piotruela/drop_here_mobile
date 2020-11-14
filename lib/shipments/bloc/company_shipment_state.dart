part of 'company_shipment_bloc.dart';

class CompanyShipmentState extends Equatable {
  final CompanyShipmentStateType type;
  final ShipmentResponse shipment;

  CompanyShipmentState({this.type, this.shipment});

  @override
  List<Object> get props => [type];
}

enum CompanyShipmentStateType { loading, error, shipment_fetched, status_changed }
