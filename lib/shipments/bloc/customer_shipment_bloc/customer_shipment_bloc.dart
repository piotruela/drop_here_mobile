import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/routes/model/api/drop_customer_spot_response_api.dart';
import 'package:drop_here_mobile/routes/model/route_response_api.dart';
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
            type: CustomerShipmentStateType.loading, drop: null, selectedProducts: null, comment: ""));

  @override
  Stream<CustomerShipmentState> mapEventToState(
    CustomerShipmentEvent event,
  ) async* {
    if (event is InitializeCreateOrder) {
      yield CustomerShipmentState(
          type: CustomerShipmentStateType.products_fetched,
          drop: event.drop,
          selectedProducts: [],
          comment: "",
          sum: 0);
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
      if (event.productRequest != null) {
        state.selectedProducts.add(event.productRequest);
      }
      yield CustomerShipmentState(
          type: CustomerShipmentStateType.products_changed,
          drop: state.drop,
          selectedProducts: products,
          comment: state.comment,
          sum: calculatePrice());
    } else if (event is RemoveProduct) {
      yield CustomerShipmentState(
          type: CustomerShipmentStateType.loading,
          drop: state.drop,
          selectedProducts: state.selectedProducts,
          comment: state.comment,
          sum: state.sum);
      List<ShipmentProductRequest> products = state.selectedProducts;
      products.remove(event.product);
      yield CustomerShipmentState(
          type: CustomerShipmentStateType.products_changed,
          drop: state.drop,
          selectedProducts: products,
          comment: state.comment,
          sum: calculatePrice());
    } else if (event is CommentChanged) {
      yield CustomerShipmentState(
          type: CustomerShipmentStateType.comment_changed,
          drop: state.drop,
          selectedProducts: state.selectedProducts,
          comment: event.comment,
          sum: state.sum);
    } else if (event is SubmitForm) {
      CustomerShipmentState(
          type: CustomerShipmentStateType.loading,
          drop: state.drop,
          selectedProducts: state.selectedProducts,
          comment: state.comment,
          sum: state.sum);
      final ShipmentCustomerSubmissionRequest request =
          ShipmentCustomerSubmissionRequest(comment: state.comment, products: state.selectedProducts);
      if (event.shipmentId != null) {
        await _customerShipmentService.updateShipment(event.companyUid, event.dropUid, event.shipmentId, request);
      } else {
        await _customerShipmentService.createShipment(event.companyUid, event.dropUid, request);
      }
      yield CustomerShipmentState(type: CustomerShipmentStateType.sent, drop: state.drop);
    }
  }

  double calculatePrice() {
    double sum = 0, productPrice;
    for (ShipmentProductRequest productRequest in state.selectedProducts ?? []) {
      productPrice = 0;
      RouteProductRouteResponse product =
          state.drop.products.firstWhere((element) => element.id == productRequest.routeProductId);
      product.routeProductResponse.customizationsWrappers.forEach((element) {
        element.customizations.forEach((customizationValue) {
          if (productRequest.customizations
              .any((requestCustomization) => requestCustomization.id == customizationValue.id))
            productPrice += customizationValue.price;
        });
      });
      productPrice += product.price;
      sum += productPrice * productRequest.quantity;
    }
    return sum;
  }
}
