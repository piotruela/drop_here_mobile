import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/shipments/model/api/company_shipment_request.dart';
import 'package:drop_here_mobile/shipments/model/api/company_shipment_response.dart';
import 'package:drop_here_mobile/shipments/service/company_shipment_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'company_shipment_event.dart';
part 'company_shipment_state.dart';

ShipmentResponse shipmentResponse = ShipmentResponse(
    companyComment: "Typ jest jakis dziwny, maca kazde zamowienie zanim zaplaci, uwazac!",
    companyUid: "firma8s4jwJ3",
    companyName: "firma8",
    createdAt: DateTime(2020, 01, 01, 02, 02, 02),
    customerComment: "Hello please give me best quaility products. I will pick up my products as soon as possible.",
    customerFirstName: "Adam",
    customerLastName: "Nowak",
    status: ShipmentStatus.ACCEPTED,
    summarizedAmount: 21.37,
    id: 123,
    dropUid: "Drop-k4zQy8UQYeDu",
    flows: [
      ShipmentFlowResponse(
        status: ShipmentStatus.PLACED,
        createdAt: DateTime(2020, 01, 01, 01, 01, 01),
      ),
      ShipmentFlowResponse(
        status: ShipmentStatus.ACCEPTED,
        createdAt: DateTime(2020, 01, 01, 02, 02, 02),
      )
    ],
    products: [
      ShipmentProductResponse(
          id: 55,
          productDescription: "Burger bardzo pyszny kizo kizo",
          productId: 54,
          productName: "Burger",
          quantity: 2,
          summarizedPrice: 1230.33,
          unitCustomizationsPrice: 12.44,
          unitPrice: 23.44,
          unitSummarizedPrice: 123.33,
          customizations: [
            ShipmentProductCustomizationResponse(
                customizationPrice: 55.33,
                customizationValue: "Bulke czostkowa",
                wrapperHeading: "Roll",
                wrapperId: 12,
                wrapperType: CustomizationType.SINGLE)
          ])
    ]);

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
      //ShipmentResponse shipmentResponse = await companyShipmentService.getCompanyShipment(event.shipmentId.toString()); TODO:Uncomment when shipments on client side exists
      yield CompanyShipmentState(type: CompanyShipmentStateType.shipment_fetched, shipment: shipmentResponse);
    }
    if (event is UpdateShipmentStatus) {
      //TODO: Delete Mock
      yield CompanyShipmentState(type: CompanyShipmentStateType.loading, shipment: null);
      ShipmentResponse toUpdate = shipmentResponse;
      toUpdate.status = ShipmentStatus.DELIVERED;
      toUpdate.flows
          .add(ShipmentFlowResponse(status: ShipmentStatus.DELIVERED, createdAt: DateTime(2020, 02, 02, 02, 02, 02)));
      //ResourceOperationResponse response = await companyShipmentService.updateShipmentStatus(ShipmentCompanyDecisionRequest(), event.shipmentId.toString()); TODO:Uncomment when shipments on client side exists
      yield CompanyShipmentState(type: CompanyShipmentStateType.shipment_fetched, shipment: toUpdate);
    }
  }
}
