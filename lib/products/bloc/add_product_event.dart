part of 'add_product_bloc.dart';

abstract class AddProductEvent extends Equatable {
  const AddProductEvent();
}

class FormInitialized extends AddProductEvent {
  @override
  List<Object> get props => [];
}

class FormChanged extends AddProductEvent {
  final ProductManagementRequest product;

  FormChanged({this.product});

  @override
  List<Object> get props => [product];
}

class CustomizationAdded extends AddProductEvent {
  final ProductCustomizationWrapperRequest customization;

  CustomizationAdded({this.customization});

  @override
  List<Object> get props => [customization];
}

class EditCustomization extends AddProductEvent {
  final int customizationIndex;
  final ProductCustomizationWrapperRequest customization;

  EditCustomization({this.customizationIndex, this.customization});

  @override
  List<Object> get props => [customizationIndex, customization];
}

class CustomizationRemoved extends AddProductEvent {
  final ProductCustomizationWrapperRequest customization;

  CustomizationRemoved({this.customization});

  @override
  List<Object> get props => [customization];
}

class PhotoChanged extends AddProductEvent {
  final PickedFile photo;

  PhotoChanged({this.photo});

  @override
  List<Object> get props => [photo];
}

class CategoryAdded extends AddProductEvent {
  final String addedCategory;

  CategoryAdded({this.addedCategory});

  @override
  List<Object> get props => [addedCategory];
}

class CategoryRemoved extends AddProductEvent {
  CategoryRemoved();
  @override
  List<Object> get props => [];
}

class FormSubmitted extends AddProductEvent {
  final Image photo;
  final ProductManagementRequest product;

  FormSubmitted({this.photo, this.product});

  @override
  List<Object> get props => [photo, product];
}
