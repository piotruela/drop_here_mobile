part of 'customer_shipment_details_bloc.dart';

abstract class CustomerShipmentDetailsEvent extends Equatable {
  const CustomerShipmentDetailsEvent();
}

class FetchShipmentDetails extends CustomerShipmentDetailsEvent {
  final int shipmentId;

  FetchShipmentDetails({this.shipmentId});

  @override
  List<Object> get props => [shipmentId];
}

class UpdateShipmentStatus extends CustomerShipmentDetailsEvent {
  final int shipmentId;
  final String companyUid;
  final String dropUid;
  final String comment;
  final CustomerDecision decision;

  UpdateShipmentStatus({this.shipmentId, this.companyUid, this.dropUid, this.comment, this.decision});

  @override
  List<Object> get props => [shipmentId, comment,companyUid,dropUid, decision];
}
