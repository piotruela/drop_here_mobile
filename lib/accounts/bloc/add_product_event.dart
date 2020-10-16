part of 'add_product_bloc.dart';

abstract class AddProductEvent extends Equatable {
  const AddProductEvent();
}

class FormChanged extends AddProductEvent {
  final File photo;
  final ProductManagementRequest productManagementRequest;

  FormChanged({this.photo, this.productManagementRequest});

  @override
  List<Object> get props => [photo, productManagementRequest];
}

class FormSubmitted extends AddProductEvent {
  final File photo;
  final ProductManagementRequest productManagementRequest;

  FormSubmitted({this.photo, this.productManagementRequest});

  @override
  List<Object> get props => [photo, productManagementRequest];
}

class FetchCategories extends AddProductEvent {
  final List<String> categories;

  FetchCategories({this.categories});

  @override
  List<Object> get props => [categories];
}

class FetchUnits extends AddProductEvent {
  final List<String> units;

  FetchUnits({this.units});

  @override
  List<Object> get props => [units];
}
