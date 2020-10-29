import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_user_api.dart';
import 'package:drop_here_mobile/spots/services/spots_user_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'spot_details2_event.dart';
part 'spot_details2_state.dart';

class SpotDetails2Bloc extends Bloc<SpotDetails2Event, SpotDetailsState> {
  final SpotsUserService spotsUserService = Get.find<SpotsUserService>();

  SpotDetails2Bloc() : super(SpotDetailsState());

  @override
  Stream<SpotDetailsState> mapEventToState(
    SpotDetails2Event event,
  ) async* {
    if (event is FetchSpotDetailsEvent) {
      yield SpotDetailsState(spot: null, type: SpotDetailsStateType.loading);
      final SpotDetailedCustomerResponse spot =
          await spotsUserService.getSpotDetails(event.spotUid);
      yield SpotDetailsState(spot: spot, type: SpotDetailsStateType.success);
    }
  }
}
