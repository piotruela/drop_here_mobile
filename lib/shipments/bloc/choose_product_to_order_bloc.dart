import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/products/model/api/page_api.dart';
import 'package:drop_here_mobile/products/model/order_product_model.dart';
import 'package:drop_here_mobile/products/services/product_management_service.dart';
import 'package:drop_here_mobile/shipments/ui/pages/add_product_to_order_page.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'choose_product_to_order_event.dart';
part 'choose_product_to_order_state.dart';

class ChooseProductToOrderBloc extends Bloc<ChooseProductToOrderEvent, ChooseProductToOrderState> {
  ChooseProductToOrderBloc()
      : super(ChooseProductToOrderState(type: ChooseProductToOrderStateType.initial));
  final ProductManagementService productManagementService = Get.find<ProductManagementService>();
  @override
  Stream<ChooseProductToOrderState> mapEventToState(
    ChooseProductToOrderEvent event,
  ) async* {
    if (event is ChooseProductToOrderInitial) {
      yield ChooseProductToOrderState(type: ChooseProductToOrderStateType.loading);
    } else if (event is FetchProducts) {
      final ProductsPage page = await productManagementService.getCompanyProducts();
      final List<OrderProductModel> products = [];
      for (var a in page.content) {
        products.add(OrderProductModel(productResponse: a));
      }
      yield ChooseProductToOrderState(
          type: ChooseProductToOrderStateType.products_fetched,
          selectedProducts: event.selectedProducts,
          products: products);
    } else if (event is ProductSelected) {
      Get.to(AddProductToOrderPage(event.product));
    }
  }
}
