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

class CustomizationRemoved extends AddProductEvent {
  final ProductCustomizationWrapperRequest customization;

  CustomizationRemoved({this.customization});

  @override
  List<Object> get props => [customization];
}

class PhotoChanged extends AddProductEvent {
  final File photo;

  PhotoChanged({this.photo});

  @override
  List<Object> get props => [photo];
}

class CategoryAdded extends AddProductEvent {
  final String categoryName;

  CategoryAdded({this.categoryName});

  @override
  List<Object> get props => [categoryName];
}

class FormSubmitted extends AddProductEvent {
  final File photo;
  final ProductManagementRequest product;

  FormSubmitted({this.photo, this.product});

  @override
  List<Object> get props => [photo, product];
}
