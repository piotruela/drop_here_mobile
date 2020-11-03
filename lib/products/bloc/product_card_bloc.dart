import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/products/services/product_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'product_card_event.dart';
part 'product_card_state.dart';

class ProductCardBloc extends Bloc<ProductCardEvent, ProductCardState> {
  ProductCardBloc() : super(ProductCardInitial());
  final ProductManagementService productManagementService = Get.find<ProductManagementService>();

  @override
  Stream<ProductCardState> mapEventToState(
    ProductCardEvent event,
  ) async* {
    yield ProductCardInitial();
    if (event is FetchProductPhoto) {
      Image photo = await productManagementService.getProductPhoto(event.productId.toString());
      yield ProductCardPhotoFetched(photo);
    }
  }
}
