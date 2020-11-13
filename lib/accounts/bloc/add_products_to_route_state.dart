part of 'add_products_to_route_bloc.dart';

class AddProductsToRouteState extends Equatable {
  final AddProductsToRouteStateType type;
  final List<ProductResponse> products;
  final List<RouteProductRequest> selectedProducts;

  AddProductsToRouteState({this.products, this.selectedProducts, this.type});

  @override
  List<Object> get props => [type, products, selectedProducts];
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
