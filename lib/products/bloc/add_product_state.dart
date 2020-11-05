part of 'add_product_bloc.dart';

class AddProductState extends Equatable {
  final AddProductStateType type;
  final ProductManagementRequest product;
  final File photo;
  final List<String> categories;
  final List<String> unitTypes;
  final bool categoryAdded;

  AddProductState({this.type, this.product, this.photo, this.categories, this.unitTypes, this.categoryAdded = false});

  @override
  List<Object> get props => [type, product, photo, categories, unitTypes, categoryAdded];

  bool get isFormFilled =>
      product.name != null &&
      product.category != null &&
      product.description != null &&
      product.price != null &&
      product.unit != null &&
      product.unitFraction != null;
}

enum AddProductStateType {
  loading,
  data_fetched,
  form_changed,
  fetching_error,
  category_added,
  added_successfully
}




class AddProductFormState extends Equatable {
  final ProductManagementRequest productManagementRequest;
  final List<ProductCategoryResponse> categories;
  final List<ProductUnitResponse> units;
  final File photo;
  const AddProductFormState({
    this.productManagementRequest,
    this.photo,
    this.categories,
    this.units,
  });

  AddProductFormState copyWith({
    final ProductManagementRequest productManagementRequest,
    final File photo,
    final List<ProductCategoryResponse> categories,
    final List<ProductUnitResponse> units,
    final bool showAddCategoryButton,
    bool photoNull = false,
  }) {
    return AddProductFormState(
      photo: photoNull ? null : photo ?? this.photo,
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
