import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/local_product.dart';
import 'package:drop_here_mobile/drops/model/localDrop.dart';
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
              drops: [],
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
      yield state.copyWith(products: event.products.toList());
    } else if (event is AddDrop) {
      yield AddRouteFormState(
        drops: state.drops..add(event.drop),
        routeRequest: state.routeRequest,
        products: state.products,
        sellerLastName: state.sellerLastName,
        sellerFirstName: state.sellerFirstName,
      );
    } else if (event is RemoveDrop) {
      List<LocalDrop> drops = List.from(state.drops);
      drops.remove(event.drop);
      yield AddRouteFormState(
        routeRequest: state.routeRequest,
        drops: drops,
        products: state.products,
        sellerLastName: state.sellerLastName,
        sellerFirstName: state.sellerFirstName,
      );
    } else if (event is FormSubmitted) {
      for (LocalProduct p in state.products) {
        event.routeRequest.products.add(RouteProductRequest(
            price: p.price, amount: p.amount, limitedAmount: !p.unlimited, productId: p.id));
      }
      for (LocalDrop d in state.drops) {
        event.routeRequest.drops.add(RouteDropRequest(
          name: d.name,
          spotId: d.spotId,
          description: d.description,
          startTime: d.startTime,
          endTime: d.endTime,
        ));
      }
      var response = await routeManagementService.createRoute(event.routeRequest);
      print(response);
      Get.back();
    }
  }
}
