import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/products/services/product_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final ProductManagementService productManagementService = Get.find<ProductManagementService>();
  AddProductBloc()
      : super(AddProductState(
            type: AddProductStateType.loading,
            product: null,
            photo: null,
            categories: null,
            unitTypes: null));

  @override
  Stream<AddProductState> mapEventToState(AddProductEvent event) async* {
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
          addedCategory: null);
    } else if (event is FormChanged) {
      yield AddProductState(
          type: AddProductStateType.form_changed,
          product: event.product,
          photo: state.photo,
          categories: state.categories,
          unitTypes: state.unitTypes,
          addedCategory: state.addedCategory);
    } else if (event is CustomizationAdded) {
      List<ProductCustomizationWrapperRequest> customizations =
          state.product.productCustomizationWrappers;
      customizations.add(event.customization);
      yield AddProductState(
          type: AddProductStateType.form_changed,
          product: state.product.copyWith(productCustomizationWrappers: customizations),
          photo: state.photo,
          categories: state.categories,
          unitTypes: state.unitTypes,
          addedCategory: state.addedCategory);
    } else if (event is EditCustomization) {
      List<ProductCustomizationWrapperRequest> customizations =
          state.product.productCustomizationWrappers;
      customizations.replaceRange(event.customizationIndex, event.customizationIndex, [event.customization]);
      customizations.add(event.customization);
      yield AddProductState(
          type: AddProductStateType.form_changed,
          product: state.product.copyWith(productCustomizationWrappers: customizations),
          photo: state.photo,
          categories: state.categories,
          unitTypes: state.unitTypes,
          addedCategory: state.addedCategory);
    } else if (event is CustomizationRemoved) {
      List<ProductCustomizationWrapperRequest> customizations =
          state.product.productCustomizationWrappers;
      customizations.remove(event.customization);
      yield AddProductState(
          type: AddProductStateType.form_changed,
          product: state.product.copyWith(productCustomizationWrappers: customizations),
          photo: state.photo,
          categories: state.categories,
          unitTypes: state.unitTypes,
          addedCategory: state.addedCategory);
    } else if (event is PhotoChanged) {
      yield AddProductState(
          type: AddProductStateType.form_changed,
          product: state.product,
          photo: event.photo,
          categories: state.categories,
          unitTypes: state.unitTypes,
          addedCategory: state.addedCategory);
    } else if (event is CategoryAdded) {
      yield AddProductState(
          type: AddProductStateType.category_added,
          product: state.product,
          photo: state.photo,
          categories: state.categories,
          unitTypes: state.unitTypes,
          addedCategory: event.addedCategory);
    } else if (event is CategoryRemoved) {
      yield AddProductState(
          type: AddProductStateType.category_removed,
          product: state.product,
          photo: state.photo,
          categories: state.categories,
          unitTypes: state.unitTypes,
          addedCategory: null);
    } else if (event is FormSubmitted) {
      print(event.product);
      /*final ResourceOperationResponse response =
          await productManagementService.addProduct(event.product);
      await productManagementService.uploadProductPhoto(event.photo, response.id.toString());*/
    }
  }
}
