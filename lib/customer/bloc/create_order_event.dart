part of 'create_order_bloc.dart';

abstract class CreateOrderEvent extends Equatable {
  const CreateOrderEvent();
}

class AddProducts extends CreateOrderEvent {
  final List<OrderProductModel> products;
  const AddProducts({this.products});

  @override
  List<Object> get props => [products];
}

class RemoveProduct extends CreateOrderEvent {
  const RemoveProduct();

  @override
  List<Object> get props => [];
}
