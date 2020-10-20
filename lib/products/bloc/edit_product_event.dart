part of 'edit_product_bloc.dart';

abstract class EditProductEvent extends Equatable {
  const EditProductEvent();
}

class FormChanged extends EditProductEvent {
  final File photo;
  final ProductManagementRequest productManagementRequest;

  FormChanged({this.photo, this.productManagementRequest});

  @override
  List<Object> get props => [photo, productManagementRequest];
}

class FormSubmitted extends EditProductEvent {
  final File photo;
  final ProductManagementRequest productManagementRequest;

  FormSubmitted({this.photo, this.productManagementRequest});

  @override
  List<Object> get props => [photo, productManagementRequest];
}
