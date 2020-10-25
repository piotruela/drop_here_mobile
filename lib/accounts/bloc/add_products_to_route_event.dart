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
