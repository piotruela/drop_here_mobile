part of 'add_product_to_order_bloc.dart';

abstract class AddProductToOrderEvent extends Equatable {
  const AddProductToOrderEvent();
}

class InitCustomization extends AddProductToOrderEvent {
  final OrderProductModel product;
  const InitCustomization(this.product);
  @override
  List<Object> get props => [product];
}

class ChangeSliderValue extends AddProductToOrderEvent {
  final double sliderValue;
  const ChangeSliderValue(this.sliderValue);
  @override
  List<Object> get props => [sliderValue];
}
