import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:drop_here_mobile/spots/services/spot_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'choose_spot_for_drop_event.dart';
part 'choose_spot_for_drop_state.dart';

class ChooseSpotForDropBloc extends Bloc<ChooseSpotForDropEvent, ChooseSpotForDropState> {
  ChooseSpotForDropBloc()
      : super(ChooseSpotForDropState(type: ChooseSpotForDropStateType.loading, spots: null, selectedSpot: null));
  final SpotManagementService spotManagementService = Get.find<SpotManagementService>();
  @override
  Stream<ChooseSpotForDropState> mapEventToState(
    ChooseSpotForDropEvent event,
  ) async* {
    if (event is AddSpotToDropPageEntered) {
      final List<SpotCompanyResponse> spots = await spotManagementService.fetchCompanySpots();
      yield ChooseSpotForDropState(
          type: ChooseSpotForDropStateType.spots_fetched, spots: spots, selectedSpot: event.selectedSpot);
    } else if (event is SelectSpot) {
      yield ChooseSpotForDropState(
          type: ChooseSpotForDropStateType.spot_changed, spots: state.spots, selectedSpot: event.spot);
    }
  }
}
