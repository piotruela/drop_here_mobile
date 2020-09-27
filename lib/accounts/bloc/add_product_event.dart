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

class NameChosen extends AddProductEvent {
  final String name;

  NameChosen({this.name});

  @override
  List<Object> get props => [name];
}

class CategoryChosen extends AddProductEvent {
  final String category;

  CategoryChosen({this.category});

  @override
  List<Object> get props => [category];
}

class DescriptionChosen extends AddProductEvent {
  final String description;

  DescriptionChosen({this.description});

  @override
  List<Object> get props => [description];
}

class PricePerUnitChosen extends AddProductEvent {
  final double pricePerUnit;

  PricePerUnitChosen({this.pricePerUnit});

  @override
  List<Object> get props => [pricePerUnit];
}

class UnitFractionChosen extends AddProductEvent {
  final double unitFraction;

  UnitFractionChosen({this.unitFraction});

  @override
  List<Object> get props => [unitFraction];
}

class FormSubmitted extends AddProductEvent {
  final UnitType unitType;

  FormSubmitted({this.unitType});

  @override
  List<Object> get props => [unitType];
}
