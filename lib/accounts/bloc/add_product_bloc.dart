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
    } else if (event is FormSubmitted) {
      //TODO
    }
  }
}
