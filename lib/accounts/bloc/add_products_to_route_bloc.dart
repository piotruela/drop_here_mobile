import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/local_product.dart';
import 'package:drop_here_mobile/products/model/api/page_api.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/products/services/product_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'add_products_to_route_event.dart';
part 'add_products_to_route_state.dart';

class AddProductsToRouteBloc extends Bloc<AddProductsToRouteEvent, AddProductsToRouteState> {
  final ProductManagementService productManagementService = Get.find<ProductManagementService>();
  AddProductsToRouteBloc()
      : super(AddProductsToRouteState(
            type: AddProductsToRouteStateType.initial, selectedProducts: {}));

  @override
  Stream<AddProductsToRouteState> mapEventToState(
    AddProductsToRouteEvent event,
  ) async* {
    if (event is FetchProducts) {
      yield AddProductsToRouteState(type: AddProductsToRouteStateType.loading);
      final ProductsPage products = await productManagementService.getCompanyProducts();
      List<LocalProduct> localProducts = [];
      for (ProductResponse product in products.content) {
        if(event.selectedProducts.any((element) => element.name == product.name)){
          localProducts.add(event.selectedProducts.firstWhere((element) => element.name == product.name));
        }
        else {
          final Image photo = await productManagementService.getProductPhoto(product.id.toString());
          localProducts.add(LocalProduct(product, photo: photo));
        }
      }
      yield AddProductsToRouteState(
          type: AddProductsToRouteStateType.products_fetched,
          productsPage: products,
          localProducts: localProducts,
          selectedProducts: event.selectedProducts);
    } else if (event is ProductSelected) {
      yield AddProductsToRouteState(
          type: AddProductsToRouteStateType.product_checked,
          localProducts: state.localProducts,
          productsPage: state.productsPage,
          selectedProducts: state.selectedProducts);
    } else if (event is AmountSelected) {
      state.selectedProducts.add(event.product);
      yield AddProductsToRouteState(
          type: AddProductsToRouteStateType.amount_chosen,
          localProducts: state.localProducts,
          productsPage: state.productsPage,
          selectedProducts: state.selectedProducts);
    } else if (event is ProductUnchecked) {
      yield AddProductsToRouteState(
          type: AddProductsToRouteStateType.product_unchecked,
          localProducts: state.localProducts,
          productsPage: state.productsPage,
          selectedProducts: state.selectedProducts);
      state.selectedProducts.removeWhere((element) => element.name == event.product.name);
      yield AddProductsToRouteState(
          type: AddProductsToRouteStateType.product_removed,
          localProducts: state.localProducts,
          productsPage: state.productsPage,
          selectedProducts: state.selectedProducts);
    }
  }
}
