import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:drop_here_mobile/spots/services/spot_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'spots_list_event.dart';
part 'spots_list_state.dart';

class SpotsMapBloc extends Bloc<SpotsMapEvent, SpotsMapState> {
  final SpotManagementService spotManagementService = Get.find<SpotManagementService>();
  SpotsMapBloc() : super(SpotsMapState());

  @override
  Stream<SpotsMapState> mapEventToState(
    SpotsMapEvent event,
  ) async* {
    if (event is FetchSpots) {
      List<SpotCompanyResponse> spots = await spotManagementService.fetchCompanySpots();
      yield SpotsFetched(spots: spots);
    } else if (event is DeleteSpot) {
      await spotManagementService.deleteSpot(event.spotId);
      List<SpotCompanyResponse> spots = await spotManagementService.fetchCompanySpots();
      yield SpotsFetched(spots: spots);
    }
  }
}
