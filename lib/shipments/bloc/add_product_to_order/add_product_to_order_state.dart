part of 'add_product_to_order_bloc.dart';

class AddProductToOrderState extends Equatable {
  const AddProductToOrderState({this.type});
  final AddProductToOrderStateType type;

  @override
  List<Object> get props => [type];
}

enum AddProductToOrderStateType {
  initial,
  error,
  loading,
  form_changed,
}
