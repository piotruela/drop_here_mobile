part of 'add_product_bloc.dart';

class AddProductFormState extends Equatable {
  final File photo;
  final UnitType unitType;
  final String name;
  final String category;
  final String description;
  final double pricePerUnit;
  final double unitFraction;
  const AddProductFormState(
      {this.name, this.description, this.category, this.pricePerUnit, this.unitFraction, this.photo, this.unitType});

  AddProductFormState copyWith({
    final File photo,
    final UnitType unitType,
    final String name,
    final String description,
    final double pricePerUnit,
    final double unitFraction,
    final String category,
  }) {
    return AddProductFormState(
      photo: photo ?? this.photo,
      unitType: unitType ?? this.unitType,
      name: name ?? this.name,
      description: description ?? this.description,
      pricePerUnit: pricePerUnit ?? this.pricePerUnit,
      unitFraction: unitFraction ?? this.unitFraction,
      category: category ?? this.category,
    );
  }

  @override
  List<Object> get props => [photo, unitType, name, description, pricePerUnit, unitFraction, category];
}

enum UnitType {
  grams,
  kilograms,
  pieces,
  liters,
}
