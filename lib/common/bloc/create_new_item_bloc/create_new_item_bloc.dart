import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/products/ui/pages/manage_product_page.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'create_new_item_event.dart';
part 'create_new_item_state.dart';

class CreateNewItemBloc extends Bloc<CreateNewItemEvent, CreateNewItemState> {
  CreateNewItemBloc() : super(CreateNewItemInitial());

  @override
  Stream<CreateNewItemState> mapEventToState(
    CreateNewItemEvent event,
  ) async* {
    if (event is CreateNewProduct) {
      Get.to(AddProductPage());
    } else if (event is CreateNewSpot) {
      //TODO Get.to(AddSpotPage());
    } else if (event is CreateNewRoute) {
      //TODO Get.to(AddRoutePage());
    } else if (event is CreateNewProfile) {
      //TODO Get.to(AddProfilePage());
    }
  }
}
