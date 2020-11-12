part of 'choose_product_to_order_bloc.dart';

abstract class ChooseProductToOrderEvent extends Equatable {
  const ChooseProductToOrderEvent();
}

class ChooseProductToOrderInitial extends ChooseProductToOrderEvent {
  @override
  List<Object> get props => [];
}

class FetchProducts extends ChooseProductToOrderEvent {
  final Set<OrderProductModel> selectedProducts;

  FetchProducts({this.selectedProducts});
  @override
  List<Object> get props => [selectedProducts];
}

class ProductSelected extends ChooseProductToOrderEvent {
  final OrderProductModel product;
  ProductSelected({this.product});
  @override
  List<Object> get props => [product];
}

class ProductUnchecked extends ChooseProductToOrderEvent {
  final OrderProductModel product;

  ProductUnchecked({this.product});
  @override
  List<Object> get props => [product];
}
