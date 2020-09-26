part of 'add_product_bloc.dart';

abstract class AddProductEvent extends Equatable {
  const AddProductEvent();
}

class AddProduct extends AddProductEvent {
  final String name;
  final String description;

  const AddProduct({this.name, this.description});

  @override
  // TODO: implement props
  List<Object> get props => [name, description];
}

class ChoosePhoto extends AddProductEvent {
  final File photo;

  ChoosePhoto({this.photo});

  @override
  // TODO: implement props
  List<Object> get props => [photo];
}

class ChooseUnitType extends AddProductEvent {
  final UnitType unitType;

  ChooseUnitType({this.unitType});

  @override
  // TODO: implement props
  List<Object> get props => [unitType];
}
