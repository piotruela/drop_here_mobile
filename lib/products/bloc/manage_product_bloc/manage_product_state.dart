part of 'manage_product_bloc.dart';

class ManageProductState extends Equatable {
  final ManageProductStateType type;
  final ProductManagementRequest product;
  final Image photo;
  final List<String> categories;
  final List<ProductUnitResponse> unitTypes;
  final String addedCategory;

  ManageProductState({this.type, this.product, this.photo, this.categories, this.unitTypes, this.addedCategory});

  @override
  List<Object> get props => [type, product, photo, categories, unitTypes, addedCategory];

  bool get isFormFilled =>
      isNotEmpty(product.name) &&
      product.category != null &&
      product.price != null &&
      product.unit != null &&
      product.unitFraction != null;

  ProductUnitResponse get selectedUnitType =>
      unitTypes?.firstWhere((element) => element.name == product?.unit, orElse: () => null);
}

enum ManageProductStateType {
  loading,
  data_fetched,
  form_changed,
  fetching_error,
  category_added,
  category_removed,
  added_successfully
}
