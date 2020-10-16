part of 'add_product_bloc.dart';

class AddProductFormState extends Equatable {
  final ProductManagementRequest productManagementRequest;
  final Future<List<ProductCategoryResponse>> categories;
  final Future<List<ProductUnitResponse>> units;
  final File photo;
  const AddProductFormState(
      {this.productManagementRequest, this.photo, this.categories, this.units});

  AddProductFormState copyWith({
    final ProductManagementRequest productManagementRequest,
    final File photo,
    final Future<List<ProductCategoryResponse>> categories,
    final Future<List<ProductUnitResponse>> units,
  }) {
    return AddProductFormState(
      photo: photo ?? this.photo,
      productManagementRequest: productManagementRequest ?? this.productManagementRequest,
      categories: categories ?? this.categories,
      units: units ?? this.units,
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
  List<Object> get props => [productManagementRequest, photo, categories, units];
}
