import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/products/model/order_product_model.dart';
import 'package:equatable/equatable.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  CreateOrderBloc() : super(CreateOrderState(CreateOrderStateType.initial));

  @override
  Stream<CreateOrderState> mapEventToState(
    CreateOrderEvent event,
  ) async* {
    if (event is AddProducts) {}
  }
}
