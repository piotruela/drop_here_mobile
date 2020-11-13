import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/routes/model/route_request_api.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:drop_here_mobile/spots/services/spot_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'add_drop_to_route_event.dart';
part 'add_drop_to_route_state.dart';

class AddDropToRouteBloc extends Bloc<AddDropToRouteEvent, AddDropToRouteFormState> {
  final SpotManagementService spotManagementService = Get.find<SpotManagementService>();

  AddDropToRouteBloc() : super(AddDropToRouteFormState());

  @override
  Stream<AddDropToRouteFormState> mapEventToState(
    AddDropToRouteEvent event,
  ) async* {
    if (event is CreateDropPageEntered) {
      final List<SpotCompanyResponse> spots = await spotManagementService.fetchCompanySpots();
      yield AddDropToRouteFormState(
          drop: event.drop,
          spots: spots,
          selectedSpot: spots.firstWhere((element) => element.id == event.drop.spotId, orElse: () => null));
    } else if (event is SpotSelected) {
      yield AddDropToRouteFormState(drop: state.drop, spots: state.spots, selectedSpot: event.spot);
    } else if (event is SpotRemoved) {
      yield AddDropToRouteFormState(drop: state.drop, spots: state.spots, selectedSpot: null);
    } else if (event is FormChanged) {
      yield AddDropToRouteFormState(drop: event.drop, spots: state.spots, selectedSpot: state.selectedSpot);
    } else if (event is FormSubmitted) {
      RouteDropRequest dropToReturn = state.drop.copyWith(spotId: state.selectedSpot.id);
      Get.back(result: dropToReturn);
    }
  }
}
