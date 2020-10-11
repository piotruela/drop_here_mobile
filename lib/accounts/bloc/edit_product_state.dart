part of 'edit_product_bloc.dart';

abstract class EditProductState extends Equatable {
  const EditProductState();
}

class EditProductInitial extends EditProductState {
  @override
  List<Object> get props => [];
}
