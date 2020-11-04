part of 'add_products_to_route_bloc.dart';

abstract class AddProductsToRouteEvent extends Equatable {
  const AddProductsToRouteEvent();
}

class ProductsInitial extends AddProductsToRouteEvent {
  @override
  List<Object> get props => [];
}

class FetchProducts extends AddProductsToRouteEvent {
  final Set<LocalProduct> selectedProducts;

  FetchProducts({this.selectedProducts});
  @override
  List<Object> get props => [selectedProducts];
}

class ProductSelected extends AddProductsToRouteEvent {
  final LocalProduct product;
  ProductSelected({this.product});
  @override
  List<Object> get props => [product];
}

class AmountSelected extends AddProductsToRouteEvent {
  final LocalProduct product;

  AmountSelected({this.product});
  @override
  List<Object> get props => [product];
}

class ProductUnchecked extends AddProductsToRouteEvent {
  final LocalProduct product;

  ProductUnchecked({this.product});
  @override
  List<Object> get props => [product];
}
