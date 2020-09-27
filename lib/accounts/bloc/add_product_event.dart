part of 'add_product_bloc.dart';

abstract class AddProductEvent extends Equatable {
  const AddProductEvent();
}

class ProductAdded extends AddProductEvent {
  final String name;
  final String description;

  const ProductAdded({this.name, this.description});

  @override
  List<Object> get props => [name, description];
}

class PhotoChosen extends AddProductEvent {
  final File photo;

  PhotoChosen({this.photo});

  @override
  List<Object> get props => [photo];
}

class UnitTypeChosen extends AddProductEvent {
  final UnitType unitType;

  UnitTypeChosen({this.unitType});

  @override
  List<Object> get props => [unitType];
}

class FormSubmitted extends AddProductEvent {
  final UnitType unitType;

  FormSubmitted({this.unitType});

  @override
  List<Object> get props => [unitType];
}
