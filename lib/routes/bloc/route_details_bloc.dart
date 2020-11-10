import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:drop_here_mobile/routes/services/route_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'route_details_event.dart';
part 'route_details_state.dart';

class RouteDetailsBloc extends Bloc<RouteDetailsEvent, RouteDetailsState> {
  RouteDetailsBloc() : super(RouteDetailsInitial());
  RouteManagementService routeManagementService = Get.find<RouteManagementService>();

  @override
  Stream<RouteDetailsState> mapEventToState(
    RouteDetailsEvent event,
  ) async* {
    yield RouteDetailsInitial();
    if (event is FetchRouteDetails) {
      RouteResponse response = await routeManagementService.fetchRoute(event.routeId);
      yield RouteDetailsFetched(response);
    }
  }
}
