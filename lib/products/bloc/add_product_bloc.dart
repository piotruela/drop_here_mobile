import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/products/services/product_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductFormState> {
  AddProductBloc()
      : super(
            AddProductFormState(photo: null, productManagementRequest: ProductManagementRequest()));

  @override
  Stream<AddProductFormState> mapEventToState(
    AddProductEvent event,
  ) async* {
    final ProductManagementService productManagementService = Get.find<ProductManagementService>();
    if (event is FormChanged) {
      ProductManagementRequest form = event.productManagementRequest;
      yield state.copyWith(productManagementRequest: form, photo: event?.photo);
    } else if (event is FormSubmitted) {
      ResourceOperationResponse response =
          await productManagementService.addProduct(state.productManagementRequest);
      productManagementService.uploadProductPhoto(state.photo, response.id.toString());
    } else if (event is FetchData) {
      List<ProductCategoryResponse> categories = await productManagementService.getCategories();
      List<ProductUnitResponse> units = await productManagementService.getUnits();
      yield state.copyWith(categories: categories, units: units);
    }
  }
}
