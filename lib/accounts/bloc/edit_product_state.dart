part of 'edit_product_bloc.dart';

class EditProductFormState extends Equatable {
  final ProductManagementRequest productManagementRequest;
  final File photo;
  const EditProductFormState({
    this.productManagementRequest,
    this.photo,
  });

  EditProductFormState copyWith({
    final ProductManagementRequest productManagementRequest,
    final File photo,
  }) {
    return EditProductFormState(
      photo: photo ?? this.photo,
      productManagementRequest: productManagementRequest ?? this.productManagementRequest,
    );
  }

  bool isFilled() {
    return productManagementRequest?.name != null &&
        productManagementRequest?.unit != null &&
        productManagementRequest?.price != null &&
        //TODO add category
        // productManagementRequest?.category != null &&
        productManagementRequest?.unitFraction != null;
  }

  @override
  List<Object> get props => [productManagementRequest, photo];
}
