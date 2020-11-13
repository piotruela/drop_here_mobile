part of 'add_product_to_order_bloc.dart';

abstract class AddProductToOrderEvent extends Equatable {
  const AddProductToOrderEvent();
}

class InitCustomization extends AddProductToOrderEvent {
  const InitCustomization();
  @override
  List<Object> get props => throw UnimplementedError();
}
