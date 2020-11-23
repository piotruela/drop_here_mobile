import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/shipments/model/api/company_shipment_response.dart';
import 'package:drop_here_mobile/shipments/model/api/customer_shipment_request.dart';
import 'package:drop_here_mobile/shipments/service/customer_shipment_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'customer_shipment_details_event.dart';
part 'customer_shipment_details_state.dart';

class CustomerShipmentDetailsBloc extends Bloc<CustomerShipmentDetailsEvent, CustomerShipmentDetailsState> {
  final CustomerShipmentService customerShipmentService = Get.find<CustomerShipmentService>();
  CustomerShipmentDetailsBloc()
      : super(CustomerShipmentDetailsState(type: CustomerShipmentDetailsStateType.loading, shipment: null));

  @override
  Stream<CustomerShipmentDetailsState> mapEventToState(
    CustomerShipmentDetailsEvent event,
  ) async* {
    if (event is FetchShipmentDetails) {
      yield CustomerShipmentDetailsState(type: CustomerShipmentDetailsStateType.loading, shipment: null);
      ShipmentResponse shipment = await customerShipmentService.getShipment(event.shipmentId.toString());
      yield CustomerShipmentDetailsState(type: CustomerShipmentDetailsStateType.shipment_fetched, shipment: shipment);
    } else if (event is UpdateShipmentStatus) {
      yield CustomerShipmentDetailsState(type: CustomerShipmentDetailsStateType.loading, shipment: state.shipment);
      ResourceOperationResponse response = await customerShipmentService.updateShipmentStatus(
          event.companyUid,
          event.dropUid,
          event.shipmentId.toString(),
          ShipmentCustomerDecisionRequest(comment: event.comment, customerDecision: event.decision));
      ShipmentResponse shipment = await customerShipmentService.getShipment(event.shipmentId.toString());
      yield CustomerShipmentDetailsState(type: CustomerShipmentDetailsStateType.shipment_fetched, shipment: shipment);
    }
  }
}
