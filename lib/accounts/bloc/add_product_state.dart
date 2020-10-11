part of 'add_product_bloc.dart';

class AddProductFormState extends Equatable {
  final ProductManagementRequest productManagementRequest;
  final File photo;
  const AddProductFormState({
    this.productManagementRequest,
    this.photo,
  });

  AddProductFormState copyWith({
    final ProductManagementRequest productManagementRequest,
    final File photo,
  }) {
    return AddProductFormState(
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
