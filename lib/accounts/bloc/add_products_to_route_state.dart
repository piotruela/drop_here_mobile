part of 'add_products_to_route_bloc.dart';

class AddProductsToRouteState extends Equatable {
  final AddProductsToRouteStateType type;
  final ProductsPage productsPage;
  final Set<LocalProduct> selectedProducts;
  final List<LocalProduct> localProducts;
  final LocalProduct checkedProduct;
  final bool unlimited;

  AddProductsToRouteState(
      {this.productsPage,
      this.selectedProducts,
      this.localProducts,
      this.checkedProduct,
      this.type,
      this.unlimited});

  @override
  List<Object> get props => [type, productsPage, selectedProducts, localProducts, unlimited];
}

enum AddProductsToRouteStateType {
  initial,
  loading,
  products_fetched,
  product_checked,
  product_unchecked,
  product_removed,
  unlimited_toggled,
  amount_chosen,
  error
}
