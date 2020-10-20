part of 'product_details_bloc.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();
}

class ProductDetailsInitial extends ProductDetailsState {
  @override
  List<Object> get props => [];
}

class ProductDetailsFetched extends ProductDetailsState {
  final Product product;

  ProductDetailsFetched(this.product);

  @override
  List<Object> get props => [product];
}
