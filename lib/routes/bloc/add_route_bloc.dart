import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/local_product.dart';
import 'package:drop_here_mobile/routes/model/route_request_api.dart';
import 'package:drop_here_mobile/routes/services/route_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'add_route_event.dart';
part 'add_route_state.dart';

class AddRouteBloc extends Bloc<AddRouteEvent, AddRouteFormState> {
  RouteManagementService routeManagementService = Get.find<RouteManagementService>();
  AddRouteBloc()
      : super(AddRouteFormState(
            routeRequest: UnpreparedRouteRequest(
              //TODO add parameters here (or not)
              products: [],
            ),
            products: [],
            drops: []));

  @override
  Stream<AddRouteFormState> mapEventToState(
    AddRouteEvent event,
  ) async* {
    if (event is FormChanged) {
      UnpreparedRouteRequest form = event.routeRequest;
      yield state.copyWith(
          routeRequest: form,
          sellerFirstName: event.sellerFirstName,
          sellerLastName: event.sellerLastName);
    } else if (event is AddProducts) {
      yield state.copyWith(products: event.products);
    } else if (event is FormSubmitted) {
      for (LocalProduct p in state.products) {
        event.routeRequest.products.add(RouteProductRequest(
            price: p.price, amount: p.amount, limitedAmount: !p.unlimited, productId: p.id));
      }
      var response = await routeManagementService.createRoute(event.routeRequest);
      print(response);
      Get.back();
    }
  }
}
