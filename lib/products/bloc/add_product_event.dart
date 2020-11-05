part of 'add_product_bloc.dart';

abstract class AddProductEvent2 extends Equatable {
  const AddProductEvent2();
}

class FormInitialized extends AddProductEvent2 {
  @override
  List<Object> get props => [];
}

class FormChanged2 extends AddProductEvent2 {
  final ProductManagementRequest product;

  FormChanged2({this.product});

  @override
  List<Object> get props => [product];
}

class PhotoChanged extends AddProductEvent2 {
  final File photo;

  PhotoChanged({this.photo});

  @override
  List<Object> get props => [photo];
}

class CategoryAdded extends AddProductEvent2 {
  final String categoryName;

  CategoryAdded({this.categoryName});

  @override
  List<Object> get props => [categoryName];
}

class FormSubmitted2 extends AddProductEvent2 {
  final File photo;
  final ProductManagementRequest product;

  FormSubmitted2({this.photo, this.product});

  @override
  List<Object> get props => [photo, product];
}

abstract class AddProductEvent extends Equatable {
  const AddProductEvent();
}

class FormChanged extends AddProductEvent {
  final File photo;
  final ProductManagementRequest productManagementRequest;
  final List<ProductCategoryResponse> categories;
  final bool photoNull;

  FormChanged({this.photo, this.productManagementRequest, this.categories, this.photoNull});

  @override
  List<Object> get props => [
        photo,
        productManagementRequest,
        categories,
        photoNull,
      ];
}

class FormSubmitted extends AddProductEvent {
  final File photo;
  final ProductManagementRequest productManagementRequest;

  FormSubmitted({this.photo, this.productManagementRequest});

  @override
  List<Object> get props => [photo, productManagementRequest];
}

class FetchData extends AddProductEvent {
  final List<String> categories;

  FetchData({this.categories});

  @override
  List<Object> get props => [categories];
}
