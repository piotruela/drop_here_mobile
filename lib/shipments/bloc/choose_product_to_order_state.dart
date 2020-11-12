part of 'choose_product_to_order_bloc.dart';

class ChooseProductToOrderState extends Equatable {
  final ChooseProductToOrderStateType type;
  final Set<OrderProductModel> selectedProducts;
  final List<OrderProductModel> products;
  const ChooseProductToOrderState({this.type, this.selectedProducts, this.products});

  @override
  List<Object> get props => [type, selectedProducts, products];
}

enum ChooseProductToOrderStateType {
  initial,
  loading,
  products_fetched,
  products_changed,
  error,
}
