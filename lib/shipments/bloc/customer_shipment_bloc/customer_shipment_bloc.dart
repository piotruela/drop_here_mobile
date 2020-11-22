import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/routes/model/api/drop_customer_spot_response_api.dart';
import 'package:drop_here_mobile/routes/services/drops_user_service.dart';
import 'package:drop_here_mobile/shipments/model/api/company_shipment_response.dart';
import 'package:drop_here_mobile/shipments/model/api/customer_shipment_request.dart';
import 'package:drop_here_mobile/shipments/service/customer_shipment_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'customer_shipment_event.dart';
part 'customer_shipment_state.dart';

class CustomerShipmentBloc extends Bloc<CustomerShipmentEvent, CustomerShipmentState> {
  final DropsUserService _dropsUserService = Get.find<DropsUserService>();
  final CustomerShipmentService _customerShipmentService = Get.find<CustomerShipmentService>();
  CustomerShipmentBloc()
      : super(CustomerShipmentState(
            type: CustomerShipmentStateType.loading, drop: null, selectedProducts: null, comment: "", sum: 0));

  @override
  Stream<CustomerShipmentState> mapEventToState(
    CustomerShipmentEvent event,
  ) async* {
    if (event is InitializeCreateOrder) {
      yield CustomerShipmentState(
          type: CustomerShipmentStateType.products_fetched, drop: event.drop, selectedProducts: [], comment: "");
    } else if (event is InitializeEditOrder) {
      final DropDetailedCustomerResponse drop = await _dropsUserService.fetchDrop(event.dropUid);
      yield CustomerShipmentState(
          type: CustomerShipmentStateType.products_fetched,
          drop: drop,
          selectedProducts: event.order.products.map((e) => e.toRequest).toList(),
          comment: event.order.customerComment,
          sum: event.order.summarizedAmount);
    } else if (event is AddProduct) {
      List<ShipmentProductRequest> products = state.selectedProducts;
      double amount = 0;
      if(event.productRequest != null){
        state.selectedProducts.add(event.productRequest);
        amount = event.amount;
      }
      yield CustomerShipmentState(
          type: CustomerShipmentStateType.products_changed,
          drop: state.drop,
          selectedProducts: products,
          comment: state.comment,
          sum: state.sum + amount
      );
    } else if (event is RemoveProduct) {
      yield CustomerShipmentState(
          type: CustomerShipmentStateType.loading,
          drop: state.drop,
          selectedProducts: state.selectedProducts,
          comment: state.comment);
      List<ShipmentProductRequest> products = state.selectedProducts;
      products.remove(event.product);
      yield CustomerShipmentState(
          type: CustomerShipmentStateType.products_changed,
          drop: state.drop,
          selectedProducts: products,
          comment: state.comment,
          sum: state.sum - event.amount);
    } else if (event is CommentChanged) {
      yield CustomerShipmentState(
          type: CustomerShipmentStateType.comment_changed,
          drop: state.drop,
          selectedProducts: state.selectedProducts,
          comment: event.comment);
    } else if (event is SubmitForm) {
      CustomerShipmentState(
          type: CustomerShipmentStateType.loading,
          drop: state.drop,
          selectedProducts: state.selectedProducts,
          comment: state.comment);
      final ShipmentCustomerSubmissionRequest request =
          ShipmentCustomerSubmissionRequest(comment: state.comment, products: state.selectedProducts);
      if (event.shipmentId != null) {
        await _customerShipmentService.updateShipment(event.companyUid, event.dropUid, event.shipmentId, request);
      } else {
        await _customerShipmentService.createShipment(event.companyUid, event.dropUid, request);
      }
      CustomerShipmentState(type: CustomerShipmentStateType.sent);
    }
  }
}