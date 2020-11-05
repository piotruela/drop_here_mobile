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

class AddProductBloc2 extends Bloc<AddProductEvent2, AddProductState> {
  final ProductManagementService productManagementService = Get.find<ProductManagementService>();
  AddProductBloc2()
      : super(AddProductState(
            type: AddProductStateType.loading,
            product: null,
            photo: null,
            categories: null,
            unitTypes: null));

  @override
  Stream<AddProductState> mapEventToState(AddProductEvent2 event) async* {
    if (event is FormInitialized) {
      AddProductState(
          type: AddProductStateType.loading,
          product: null,
          photo: null,
          categories: null,
          unitTypes: null);
      final List<String> categories = await productManagementService.getCategories();
      final List<String> units = await productManagementService.getUnits();
      yield AddProductState(
          type: AddProductStateType.data_fetched,
          product: ProductManagementRequest(productCustomizationWrappers: []),
          categories: categories,
          unitTypes: units,
          categoryAdded: false);
    } else if (event is FormChanged2) {
      yield AddProductState(
          type: AddProductStateType.form_changed,
          product: event.product,
          photo: state.photo,
          categories: state.categories,
          unitTypes: state.unitTypes,
          categoryAdded: state.categoryAdded);
    } else if (event is PhotoChanged) {
      yield AddProductState(
          type: AddProductStateType.form_changed,
          product: state.product,
          photo: event.photo,
          categories: state.categories,
          unitTypes: state.unitTypes,
          categoryAdded: state.categoryAdded);
    } else if (event is CategoryAdded) {
      List<String> categories = state.categories;
      categories.add(event.categoryName);
      yield AddProductState(
          type: AddProductStateType.category_added,
          product: state.product,
          photo: state.photo,
          categories: categories,
          unitTypes: state.unitTypes,
          categoryAdded: true);
    } else if (event is FormSubmitted2) {
      print(event.product);
      /*final ResourceOperationResponse response =
          await productManagementService.addProduct(event.product);
      await productManagementService.uploadProductPhoto(event.photo, response.id.toString());*/
    }
  }
}

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
      // yield AddProductFormState(
      //     productManagementRequest: form,
      //     photo: event.photo,
      //     showAddCategoryButton: event.showAddCategoryButton);
      yield state.copyWith(
        productManagementRequest: form,
        photo: event?.photo,
        categories: event.categories,
        photoNull: event.photoNull ?? false,
      );
    } else if (event is FormSubmitted) {
      ResourceOperationResponse response =
          await productManagementService.addProduct(state.productManagementRequest);
      productManagementService.uploadProductPhoto(state.photo, response.id.toString());
    } else if (event is FetchData) {
      /*List<ProductCategoryResponse> categories = await productManagementService.getCategories();
      List<ProductUnitResponse> units = await productManagementService.getUnits();
      yield state.copyWith(categories: categories, units: units);*/
    }
  }
}
