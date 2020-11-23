import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/shipments/model/api/company_shipment_request.dart';
import 'package:drop_here_mobile/shipments/model/api/company_shipment_response.dart';
import 'package:drop_here_mobile/shipments/service/company_shipment_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'company_shipment_event.dart';
part 'company_shipment_state.dart';

class CompanyShipmentBloc extends Bloc<CompanyShipmentEvent, CompanyShipmentState> {
  final CompanyShipmentService companyShipmentService = Get.find<CompanyShipmentService>();
  CompanyShipmentBloc() : super(CompanyShipmentState(type: CompanyShipmentStateType.loading, shipment: null));

  @override
  Stream<CompanyShipmentState> mapEventToState(
    CompanyShipmentEvent event,
  ) async* {
    if (event is FetchShipmentDetails) {
      yield CompanyShipmentState(type: CompanyShipmentStateType.loading, shipment: null);
      Future.delayed(const Duration(milliseconds: 500));
      ShipmentResponse shipmentResponse = await companyShipmentService.getCompanyShipment(event.shipmentId.toString());
      yield CompanyShipmentState(type: CompanyShipmentStateType.shipment_fetched, shipment: shipmentResponse);
    }
    if (event is UpdateShipmentStatus) {
      yield CompanyShipmentState(type: CompanyShipmentStateType.loading, shipment: null);
      ResourceOperationResponse response = await companyShipmentService.updateShipmentStatus(
          ShipmentCompanyDecisionRequest(comment: event.comment, companyDecision: event.companyDecision), event.shipmentId.toString());
      ShipmentResponse shipmentResponse = await companyShipmentService.getCompanyShipment(event.shipmentId.toString());
      yield CompanyShipmentState(type: CompanyShipmentStateType.shipment_fetched, shipment: shipmentResponse);
    }
  }
}
