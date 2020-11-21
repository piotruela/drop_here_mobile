import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/products/services/product_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

part 'manage_product_event.dart';
part 'manage_product_state.dart';

class ManageProductBloc extends Bloc<ManageProductEvent, ManageProductState> {
  final ProductManagementService productManagementService = Get.find<ProductManagementService>();
  ManageProductBloc({ProductManagementRequest product, Image photo})
      : super(ManageProductState(
            type: ManageProductStateType.loading,
            product: product ?? ProductManagementRequest(productCustomizationWrappers: []),
            photo: photo,
            categories: null,
            unitTypes: null));

  @override
  Stream<ManageProductState> mapEventToState(ManageProductEvent event) async* {
    if (event is FormInitialized) {
      final List<String> categories = await productManagementService.getCategories();
      final List<ProductUnitResponse> units = await productManagementService.getUnits();
      yield ManageProductState(
          type: ManageProductStateType.data_fetched,
          product: state.product,
          photo: state.photo,
          categories: categories,
          unitTypes: units,
          addedCategory: null);
    } else if (event is FormChanged) {
      yield ManageProductState(
          type: ManageProductStateType.form_changed,
          product: event.product,
          photo: state.photo,
          categories: state.categories,
          unitTypes: state.unitTypes,
          addedCategory: state.addedCategory);
    } else if (event is CustomizationAdded) {
      List<ProductCustomizationWrapperRequest> customizations = state.product.productCustomizationWrappers;
      customizations.add(event.customization);
      yield ManageProductState(
          type: ManageProductStateType.form_changed,
          product: state.product.copyWith(productCustomizationWrappers: customizations),
          photo: state.photo,
          categories: state.categories,
          unitTypes: state.unitTypes,
          addedCategory: state.addedCategory);
    } else if (event is EditCustomization) {
      List<ProductCustomizationWrapperRequest> customizations = state.product.productCustomizationWrappers;
      if (event.customization != null) {
        customizations[event.customizationIndex] = event.customization;
      }
      yield ManageProductState(
          type: ManageProductStateType.form_changed,
          product: state.product.copyWith(productCustomizationWrappers: customizations),
          photo: state.photo,
          categories: state.categories,
          unitTypes: state.unitTypes,
          addedCategory: state.addedCategory);
    } else if (event is CustomizationRemoved) {
      List<ProductCustomizationWrapperRequest> customizations = state.product.productCustomizationWrappers;
      customizations.remove(event.customization);
      yield ManageProductState(
          type: ManageProductStateType.form_changed,
          product: state.product.copyWith(productCustomizationWrappers: customizations),
          photo: state.photo,
          categories: state.categories,
          unitTypes: state.unitTypes,
          addedCategory: state.addedCategory);
    } else if (event is PhotoChanged) {
      Image photo;
      if (event.photo != null) {
        photo = Image.file(File(event.photo.path));
      }
      yield ManageProductState(
          type: ManageProductStateType.form_changed,
          product: state.product,
          photo: photo,
          categories: state.categories,
          unitTypes: state.unitTypes,
          addedCategory: state.addedCategory);
    } else if (event is CategoryAdded) {
      yield ManageProductState(
          type: ManageProductStateType.category_added,
          product: state.product.copyWith(category: event.addedCategory),
          photo: state.photo,
          categories: state.categories,
          unitTypes: state.unitTypes,
          addedCategory: event.addedCategory);
    } else if (event is CategoryRemoved) {
      yield ManageProductState(
          type: ManageProductStateType.category_removed,
          product: state.product,
          photo: state.photo,
          categories: state.categories,
          unitTypes: state.unitTypes,
          addedCategory: null);
    } else if (event is FormSubmitted) {
      ResourceOperationResponse response;
      if (event.productId != null) {
        response = await productManagementService.updateProduct(event.product, event.productId.toString());
      } else {
        response = await productManagementService.addProduct(event.product);
      }
      if (event.photo != null) {
        await productManagementService.uploadProductPhoto(event.photo, response.id.toString());
      }
      yield ManageProductState(type: ManageProductStateType.added_successfully);
    }
  }
}
