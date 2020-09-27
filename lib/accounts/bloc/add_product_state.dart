part of 'add_product_bloc.dart';

// abstract class AddProductState extends Equatable {
//   const AddProductState();
//
//   final UnitType unitType = UnitType.kilograms;
// }
//
// class AddProductInitial extends AddProductState {
//   const AddProductInitial();
//
//   @override
//   List<Object> get props => [];
// }

class AddProductFormState extends Equatable {
  final File photo;
  final UnitType unitType;
  const AddProductFormState({this.photo, this.unitType});

  AddProductFormState copyWith({
    final File photo,
    final UnitType unitType,
  }) {
    return AddProductFormState(
      photo: photo ?? this.photo,
      unitType: unitType ?? this.unitType,
    );
  }

  @override
  List<Object> get props => [photo, unitType];
}

// class ProductPhotoChosen extends AddProductState {
//   final File photo;
//
//   ProductPhotoChosen(this.photo);
//
//   @override
//   List<Object> get props => [photo];
// }
//
// class ProductUnitTypeChosen extends AddProductState {
//   final UnitType unitType;
//
//   ProductUnitTypeChosen(this.unitType);
//
//   @override
//   List<Object> get props => [unitType];
// }

enum UnitType {
  grams,
  kilograms,
  pieces,
  liters,
}
