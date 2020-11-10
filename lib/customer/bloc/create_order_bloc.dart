import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  CreateOrderBloc() : super(CreateOrderState(CreateOrderStateType.initial));

  @override
  Stream<CreateOrderState> mapEventToState(
    CreateOrderEvent event,
  ) async* {
    if (event is AddProduct) {}
  }
}
