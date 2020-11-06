part of 'add_product_bloc.dart';

class AddProductState extends Equatable {
  final AddProductStateType type;
  final ProductManagementRequest product;
  final File photo;
  final List<String> categories;
  final List<String> unitTypes;
  final String addedCategory;

  AddProductState(
      {this.type, this.product, this.photo, this.categories, this.unitTypes, this.addedCategory});

  @override
  List<Object> get props => [type, product, photo, categories, unitTypes, addedCategory];

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
  category_removed,
  added_successfully
}
