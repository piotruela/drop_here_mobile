part of 'add_products_to_route_bloc.dart';

abstract class AddProductsToRouteEvent extends Equatable {
  const AddProductsToRouteEvent();
}

class ProductsInitial extends AddProductsToRouteEvent {
  @override
  List<Object> get props => [];
}

class ToggleAmount extends AddProductsToRouteEvent {
  final bool value;
  final LocalProduct product;
  final ProductsPage products;
  final LinkedHashSet<LocalProduct> selectedProducts;
  final LinkedHashSet<LocalProduct> localProducts;

  ToggleAmount(this.value, this.product, this.products, this.selectedProducts, this.localProducts);
  @override
  List<Object> get props => [value, product, products, selectedProducts, localProducts];
}

class FetchProducts extends AddProductsToRouteEvent {
  final LinkedHashSet<LocalProduct> selectedProducts;

  FetchProducts(this.selectedProducts);
  @override
  List<Object> get props => [selectedProducts];
}

class AddProductToSelected extends AddProductsToRouteEvent {
  final LocalProduct product;
  final ProductsPage products;
  final LinkedHashSet<LocalProduct> selectedProducts;
  final LinkedHashSet<LocalProduct> localProducts;

  AddProductToSelected(this.product, this.products, this.selectedProducts, this.localProducts);
  @override
  List<Object> get props => [product, products, selectedProducts, localProducts];
}

class RemoveProductFromSelected extends AddProductsToRouteEvent {
  final ProductResponse product;
  final ProductsPage products;
  final LinkedHashSet<LocalProduct> selectedProducts;
  final LinkedHashSet<LocalProduct> localProducts;

  RemoveProductFromSelected(this.product, this.products, this.selectedProducts, this.localProducts);
  @override
  List<Object> get props => [product, products, selectedProducts, localProducts];
}
