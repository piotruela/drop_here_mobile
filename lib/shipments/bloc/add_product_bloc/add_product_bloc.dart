import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(AddProductState(type: AddProductStateType.loading));

  @override
  Stream<AddProductState> mapEventToState(
    AddProductEvent event,
  ) async* {}
}
