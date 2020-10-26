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
  final ProductsPage productsPage;
  final LinkedHashSet<LocalProduct> selectedProducts;
  final List<LocalProduct> localProducts;

  ProductsFetched({this.productsPage, this.selectedProducts, this.localProducts});

  @override
  List<Object> get props => [productsPage, selectedProducts, localProducts];
}
