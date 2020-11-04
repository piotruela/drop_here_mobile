part of 'product_card_bloc.dart';

abstract class ProductCardEvent extends Equatable {
  const ProductCardEvent();
}

class FetchProductPhoto extends ProductCardEvent {
  final int productId;

  FetchProductPhoto(this.productId);

  @override
  List<Object> get props => [productId];
}
