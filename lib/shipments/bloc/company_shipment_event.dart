part of 'company_shipment_bloc.dart';

abstract class CompanyShipmentEvent extends Equatable {
  CompanyShipmentEvent();
}

class FetchShipmentDetails extends CompanyShipmentEvent {
  final int shipmentId;

  FetchShipmentDetails({this.shipmentId});

  @override
  List<Object> get props => [shipmentId];
}

class UpdateShipmentStatus extends CompanyShipmentEvent {
  final int shipmentId;
  final String comment;
  final CompanyDecision companyDecision;

  UpdateShipmentStatus({this.shipmentId, this.comment, this.companyDecision});

  @override
  List<Object> get props => [shipmentId, comment, companyDecision];
}
