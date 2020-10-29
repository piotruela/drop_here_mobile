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
      yield state.copyWith(routeRequest: form);
    } else if (event is AddProducts) {
      yield state.copyWith(products: event.products);
    } else if (event is FormSubmitted) {
      //TODO do sth
      print(state.routeRequest.toString());

      for (LocalProduct p in state.products) {
        // if(state.routeRequest.products == null){
        //   state.routeRequest.products = [];
        // }
        event.routeRequest.products.add(RouteProductRequest(
            price: p.price, amount: p.amount, limitedAmount: !p.unlimited, productUid: p.id));
      }

      // print('drop[y');
      // for (RouteDropRequest a in state.drops) {
      //   event.routeRequest.drops.add(RouteDropRequest(
      //       startTime: a.startTime,
      //       name: a.name,
      //       description: a.description,
      //       endTime: a.endTime,
      //       spotId: a.spotId));
      // }
      var response = await routeManagementService.createRoute(event.routeRequest);
      print(response);
      //TODO yield state
      //yield
    }
  }
}
