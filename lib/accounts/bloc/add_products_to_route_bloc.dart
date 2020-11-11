import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/products/model/api/page_api.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/products/services/product_management_service.dart';
import 'package:drop_here_mobile/routes/model/route_request_api.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'add_products_to_route_event.dart';
part 'add_products_to_route_state.dart';

class AddProductsToRouteBloc extends Bloc<AddProductsToRouteEvent, AddProductsToRouteState> {
  final ProductManagementService productManagementService = Get.find<ProductManagementService>();
  AddProductsToRouteBloc() : super(AddProductsToRouteState(type: AddProductsToRouteStateType.initial));

  @override
  Stream<AddProductsToRouteState> mapEventToState(
    AddProductsToRouteEvent event,
  ) async* {
    if (event is FetchProducts) {
      yield AddProductsToRouteState(type: AddProductsToRouteStateType.loading);
      final ProductsPage productsPage = await productManagementService.getCompanyProducts();
      yield AddProductsToRouteState(
          type: AddProductsToRouteStateType.products_fetched,
          products: productsPage.content,
          selectedProducts: event.selectedProducts ?? []);
    } else if (event is ProductSelected) {
      yield AddProductsToRouteState(
          type: AddProductsToRouteStateType.product_checked,
          products: state.products,
          selectedProducts: state.selectedProducts);
      List<RouteProductRequest> selProducts = state.selectedProducts;
      selProducts.add(RouteProductRequest(amount: 10, limitedAmount: true, productId: event.product.id, price: 10.0));
      yield AddProductsToRouteState(
          type: AddProductsToRouteStateType.amount_chosen, products: state.products, selectedProducts: selProducts);
    } else if (event is ProductUnchecked) {
      yield AddProductsToRouteState(
          type: AddProductsToRouteStateType.product_unchecked,
          products: state.products,
          selectedProducts: state.selectedProducts);
      List<RouteProductRequest> selProducts = state.selectedProducts;
      selProducts.removeWhere((element) => element.productId == event.productId);
      yield AddProductsToRouteState(
          type: AddProductsToRouteStateType.product_removed, products: state.products, selectedProducts: selProducts);
    }
  }
}
