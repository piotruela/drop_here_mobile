import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/products/model/api/page_api.dart';
import 'package:drop_here_mobile/products/services/product_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'add_products_to_route_event.dart';
part 'add_products_to_route_state.dart';

class AddProductsToRouteBloc extends Bloc<AddProductsToRouteEvent, AddProductsToRouteState> {
  AddProductsToRouteBloc() : super(AddProductsToRouteInitial());
  final ProductManagementService productManagementService = Get.find<ProductManagementService>();

  @override
  Stream<AddProductsToRouteState> mapEventToState(
    AddProductsToRouteEvent event,
  ) async* {
    yield AddProductsToRouteInitial();
    if (event is FetchProducts) {
      ProductsPage products = await productManagementService.getCompanyProducts();
      yield (ProductsFetched(products));
    }
  }
}
