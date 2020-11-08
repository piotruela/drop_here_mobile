import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_user_api.dart';
import 'package:drop_here_mobile/spots/services/spots_user_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'spot_details_event.dart';
part 'spot_details_state.dart';

class SpotDetailsBloc extends Bloc<SpotDetailsEvent, SpotDetailsState> {
  final SpotsUserService spotsUserService = Get.find<SpotsUserService>();

  SpotDetailsBloc() : super(SpotDetailsState());

  @override
  Stream<SpotDetailsState> mapEventToState(
    SpotDetailsEvent event,
  ) async* {
    if (event is FetchSpotDetailsEvent) {
      yield SpotDetailsState(spot: null, type: SpotDetailsStateType.loading);
      final SpotDetailedCustomerResponse spot =
          await spotsUserService.getSpotDetails(event.spotUid);
      yield SpotDetailsState(spot: spot, type: SpotDetailsStateType.success);
    } else if (event is CloseSpotDetailsPanel) {
      yield SpotDetailsState(spot: null, type: SpotDetailsStateType.panel_closed);
    } else if (event is WrongSpotPassword) {
      yield SpotDetailsState(spot: state.spot, type: SpotDetailsStateType.failure);
    }
  }
}
