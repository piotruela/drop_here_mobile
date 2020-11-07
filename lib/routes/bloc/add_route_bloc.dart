import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/local_product.dart';
import 'package:drop_here_mobile/drops/model/localDrop.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/routes/model/route_request_api.dart';
import 'package:drop_here_mobile/routes/model/route_response_api.dart';
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
    } else if (event is FetchRoute) {
      RouteResponse response = await routeManagementService.fetchRoute(event.routeId);
      final List<LocalDrop> drops = [];
      for (DropRouteResponse drop in response.drops) {
        RouteDropRequest d = RouteDropRequest(
            name: drop.name,
            description: drop.description,
            startTime: drop.startTime.toString(),
            endTime: drop.endTime.toString(),
            spotId: drop.spot.id);
        drops.add(LocalDrop(d, drop.spot.name));
      }
      final List<LocalProduct> products = [];
      for (RouteProductRouteResponse product in response.products) {
        ProductResponse p = ProductResponse(
            name: product.productResponse.name,
            description: product.productResponse.description,
            category: product.productResponse.category,
            price: product.productResponse.price,
            unitFraction: product.productResponse.unitFraction,
            unit: product.productResponse.unit,
            id: product.productResponse.id,
            productCustomizationWrappers: product.productResponse.productCustomizationWrappers);
        products.add(LocalProduct(p));
      }
      yield AddRouteFormState(
        routeRequest: UnpreparedRouteRequest(
            name: response.name,
            description: response.description,
            profileUid: response.profileUid,
            date: response.routeDate.toString()),
        sellerFirstName: response.profileFirstName,
        sellerLastName: response.profileLastName,
        products: products,
        drops: drops,
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
