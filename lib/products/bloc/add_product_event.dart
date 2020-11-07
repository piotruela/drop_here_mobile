part of 'add_product_bloc.dart';

abstract class ManageProductEvent extends Equatable {
  const ManageProductEvent();
}

class FormInitialized extends ManageProductEvent {
  FormInitialized();
  @override
  List<Object> get props => [];
}

class FormChanged extends ManageProductEvent {
  final ProductManagementRequest product;

  FormChanged({this.product});

  @override
  List<Object> get props => [product];
}

class CustomizationAdded extends ManageProductEvent {
  final ProductCustomizationWrapperRequest customization;

  CustomizationAdded({this.customization});

  @override
  List<Object> get props => [customization];
}

class EditCustomization extends ManageProductEvent {
  final int customizationIndex;
  final ProductCustomizationWrapperRequest customization;

  EditCustomization({this.customizationIndex, this.customization});

  @override
  List<Object> get props => [customizationIndex, customization];
}

class CustomizationRemoved extends ManageProductEvent {
  final ProductCustomizationWrapperRequest customization;

  CustomizationRemoved({this.customization});

  @override
  List<Object> get props => [customization];
}

class PhotoChanged extends ManageProductEvent {
  final PickedFile photo;

  PhotoChanged({this.photo});

  @override
  List<Object> get props => [photo];
}

class CategoryAdded extends ManageProductEvent {
  final String addedCategory;

  CategoryAdded({this.addedCategory});

  @override
  List<Object> get props => [addedCategory];
}

class CategoryRemoved extends ManageProductEvent {
  CategoryRemoved();
  @override
  List<Object> get props => [];
}

class FormSubmitted extends ManageProductEvent {
  final String productId;
  final Image photo;
  final ProductManagementRequest product;

  FormSubmitted({this.productId, this.photo, this.product});

  @override
  List<Object> get props => [productId, photo, product];
}
