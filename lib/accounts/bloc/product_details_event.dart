part of 'product_details_bloc.dart';

abstract class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();
}

class FetchProductDetails extends ProductDetailsEvent {
  @override
  List<Object> get props => [];
}
