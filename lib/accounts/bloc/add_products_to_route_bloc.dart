import 'dart:async';
import 'dart:collection';

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
  AddProductsToRouteBloc() : super(AddProductsToRouteInitial());
  final ProductManagementService productManagementService = Get.find<ProductManagementService>();

  @override
  Stream<AddProductsToRouteState> mapEventToState(
    AddProductsToRouteEvent event,
  ) async* {
    yield AddProductsToRouteInitial();
    if (event is FetchProducts) {
      ProductsPage products = await productManagementService.getCompanyProducts();
      Set<LocalProduct> mySet = {};
      List<LocalProduct> localProducts = [];
      for (var product in products.content) {
        Image photo = await productManagementService.getProductPhoto(product.id.toString());
        LocalProduct p = LocalProduct(product, photo: photo);
        localProducts.add(p);
      }
      yield (ProductsFetched(
          productsPage: products,
          localProducts: localProducts,
          selectedProducts: event.selectedProducts ?? {}));
    } else if (event is AddProductToSelected) {
      event.selectedProducts.add(event.product);
      yield (ProductsFetched(
          localProducts: event.localProducts.toList(),
          productsPage: event.products,
          selectedProducts: event.selectedProducts));
    } else if (event is RemoveProductFromSelected) {
      LocalProduct product = LocalProduct(event.product);
      event.selectedProducts.remove(product);
      yield (ProductsFetched(
          localProducts: event.localProducts.toList(),
          productsPage: event.products,
          selectedProducts: event.selectedProducts));
    } else if (event is ToggleAmount) {
      event.product.limitedAmount = event.value;
      yield (ProductsFetched(
          localProducts: event.localProducts.toList(),
          productsPage: event.products,
          selectedProducts: event.selectedProducts));
    }
  }
}
