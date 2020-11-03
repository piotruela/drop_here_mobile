part of 'product_card_bloc.dart';

abstract class ProductCardState extends Equatable {
  const ProductCardState();
}

class ProductCardInitial extends ProductCardState {
  @override
  List<Object> get props => [];
}

class ProductCardPhotoFetched extends ProductCardState {
  final Image photo;

  ProductCardPhotoFetched(this.photo);
  @override
  List<Object> get props => [photo];
}
