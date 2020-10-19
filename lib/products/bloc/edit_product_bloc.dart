import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:equatable/equatable.dart';

part 'edit_product_event.dart';
part 'edit_product_state.dart';

class EditProductBloc extends Bloc<EditProductEvent, EditProductFormState> {
  EditProductBloc()
      : super(EditProductFormState(
            photo: null, productManagementRequest: ProductManagementRequest()));

  @override
  Stream<EditProductFormState> mapEventToState(
    EditProductEvent event,
  ) async* {
    if (event is FormChanged) {
      ProductManagementRequest form = event.productManagementRequest;
      yield state.copyWith(productManagementRequest: form, photo: event?.photo);
    } else if (event is FormSubmitted) {
      //TODO
    }
  }
}
