part of 'add_products_to_route_bloc.dart';

abstract class AddProductsToRouteEvent extends Equatable {
  const AddProductsToRouteEvent();
}

class ProductsInitial extends AddProductsToRouteEvent {
  @override
  List<Object> get props => [];
}

class FetchProducts extends AddProductsToRouteEvent {
  @override
  List<Object> get props => [];
}

class AddProductToSelected extends AddProductsToRouteEvent {
  final ProductResponse product;
  final ProductsPage products;
  final LinkedHashSet<ProductResponse> selectedProducts;

  AddProductToSelected(this.product, this.products, this.selectedProducts);
  @override
  List<Object> get props => [product, products, selectedProducts];
}

class RemoveProductFromSelected extends AddProductsToRouteEvent {
  final ProductResponse product;
  final ProductsPage products;
  final LinkedHashSet<ProductResponse> selectedProducts;

  RemoveProductFromSelected(this.product, this.products, this.selectedProducts);
  @override
  List<Object> get props => [product, products, selectedProducts];
}
