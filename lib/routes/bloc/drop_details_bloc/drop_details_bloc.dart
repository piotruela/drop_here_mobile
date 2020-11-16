import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/routes/model/api/drop_customer_spot_response_api.dart';
import 'package:drop_here_mobile/routes/services/drops_user_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'drop_details_event.dart';
part 'drop_details_state.dart';

class DropDetailsBloc extends Bloc<DropDetailsEvent, DropDetailsState> {
  final DropsUserService _dropsUserService = Get.find<DropsUserService>();
  DropDetailsBloc() : super(DropDetailsState(type: DropDetailsStateType.loading, drop: null));

  @override
  Stream<DropDetailsState> mapEventToState(
    DropDetailsEvent event,
  ) async* {
    if (event is FetchDropDetails) {
      yield DropDetailsState(type: DropDetailsStateType.loading, drop: null);
      final DropDetailedCustomerResponse drop = await _dropsUserService.fetchDrop(event.dropUid);
      yield DropDetailsState(type: DropDetailsStateType.fetched, drop: drop);
    }
  }
}
