part of 'create_order_bloc.dart';

abstract class CreateOrderEvent extends Equatable {
  const CreateOrderEvent();
}

class AddProduct extends Equatable {
  const AddProduct();

  @override
  List<Object> get props => [];
}

class RemoveProduct extends Equatable {
  const RemoveProduct();

  @override
  List<Object> get props => [];
}
