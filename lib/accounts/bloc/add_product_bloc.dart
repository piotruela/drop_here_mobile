import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductFormState> {
  AddProductBloc() : super(AddProductFormState(photo: null, unitType: null));

  @override
  Stream<AddProductFormState> mapEventToState(
    AddProductEvent event,
  ) async* {
    if (event is PhotoChosen) {
      yield state.copyWith(photo: event.photo);
    } else if (event is UnitTypeChosen) {
      yield state.copyWith(unitType: event.unitType);
    } else if (event is NameChosen) {
      yield state.copyWith(name: event.name);
    } else if (event is CategoryChosen) {
      yield state.copyWith(category: event.category);
    } else if (event is DescriptionChosen) {
      yield state.copyWith(description: event.description);
    } else if (event is PricePerUnitChosen) {
      yield state.copyWith(pricePerUnit: event.pricePerUnit);
    } else if (event is UnitFractionChosen) {
      yield state.copyWith(unitFraction: event.unitFraction);
    } else if (event is FormSubmitted) {
      //TODO
    }
  }
}
