import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/products/model/order_product_model.dart';
import 'package:equatable/equatable.dart';

part 'add_product_to_order_event.dart';
part 'add_product_to_order_state.dart';

class AddProductToOrderBloc extends Bloc<AddProductToOrderEvent, AddProductToOrderState> {
  AddProductToOrderBloc() : super(AddProductToOrderState(type: AddProductToOrderStateType.initial));

  @override
  Stream<AddProductToOrderState> mapEventToState(
    AddProductToOrderEvent event,
  ) async* {
    if (event is InitCustomization) {
      yield AddProductToOrderState(
          type: AddProductToOrderStateType.initial, product: event.product);
    }
  }
}
