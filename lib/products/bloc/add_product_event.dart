part of 'add_product_bloc.dart';

abstract class AddProductEvent extends Equatable {
  const AddProductEvent();
}

class FormInitialized extends AddProductEvent {
  @override
  List<Object> get props => [];
}

class FormChanged2 extends AddProductEvent {
  final ProductManagementRequest product;

  FormChanged2({this.product});

  @override
  List<Object> get props => [product];
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

class FormSubmitted2 extends AddProductEvent {
  final File photo;
  final ProductManagementRequest product;

  FormSubmitted2({this.photo, this.product});

  @override
  List<Object> get props => [photo, product];
}
