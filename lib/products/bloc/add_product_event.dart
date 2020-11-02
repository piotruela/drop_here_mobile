part of 'add_product_bloc.dart';

abstract class AddProductEvent extends Equatable {
  const AddProductEvent();
}

class FormChanged extends AddProductEvent {
  final File photo;
  final ProductManagementRequest productManagementRequest;
  final List<ProductCategoryResponse> categories;

  FormChanged({
    this.photo,
    this.productManagementRequest,
    this.categories,
  });

  @override
  List<Object> get props => [
        photo,
        productManagementRequest,
        categories,
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
