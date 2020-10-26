part of 'add_products_to_route_bloc.dart';

abstract class AddProductsToRouteState extends Equatable {
  const AddProductsToRouteState();
}

class AddProductsToRouteInitial extends AddProductsToRouteState {
  @override
  List<Object> get props => [];
}

class FetchingError extends AddProductsToRouteState {
  @override
  List<Object> get props => [];
}

class ProductsFetched extends AddProductsToRouteState {
  final ProductsPage products;
  final LinkedHashSet<LocalProduct> selectedProducts;

  ProductsFetched(this.products, this.selectedProducts);

  @override
  List<Object> get props => [products, selectedProducts];
}
