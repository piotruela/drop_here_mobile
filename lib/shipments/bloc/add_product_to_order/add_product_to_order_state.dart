part of 'add_product_to_order_bloc.dart';

class AddProductToOrderState extends Equatable {
  const AddProductToOrderState({this.type, this.product});
  final AddProductToOrderStateType type;
  final OrderProductModel product;

  @override
  List<Object> get props => [type, product];
}

enum AddProductToOrderStateType {
  initial,
  error,
  loading,
  form_changed,
}
