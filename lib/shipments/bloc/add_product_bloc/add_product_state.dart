part of 'add_product_bloc.dart';

class AddProductState extends Equatable {
  final AddProductStateType type;

  AddProductState({this.type});

  @override
  List<Object> get props => [type];
}

enum AddProductStateType { loading, initial, failure }
