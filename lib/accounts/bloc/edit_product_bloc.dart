import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_product_event.dart';
part 'edit_product_state.dart';

class EditProductBloc extends Bloc<EditProductEvent, EditProductState> {
  EditProductBloc() : super(EditProductInitial());

  @override
  Stream<EditProductState> mapEventToState(
    EditProductEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
