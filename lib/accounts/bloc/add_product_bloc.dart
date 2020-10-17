import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/product_management_api.dart';
import 'package:drop_here_mobile/accounts/services/product_management_service.dart';
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
    } else if (event is FetchCategories) {
      Future<List<ProductCategoryResponse>> categories = productManagementService.getCategories();
      yield state.copyWith(categories: categories);
    } else if (event is FetchUnits) {
      Future<List<ProductUnitResponse>> units = productManagementService.getUnits();
      yield state.copyWith(units: units);
    }
  }
}
