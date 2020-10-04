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
