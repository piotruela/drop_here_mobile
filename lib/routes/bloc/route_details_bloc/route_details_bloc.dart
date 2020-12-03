import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:drop_here_mobile/routes/services/route_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'route_details_event.dart';
part 'route_details_state.dart';

class RouteDetailsBloc extends Bloc<RouteDetailsEvent, RouteDetailsState> {
  final RouteManagementService routeManagementService = Get.find<RouteManagementService>();
  RouteDetailsBloc() : super(RouteDetailsState(type: RouteDetailsStateType.loading));

  @override
  Stream<RouteDetailsState> mapEventToState(
    RouteDetailsEvent event,
  ) async* {
    if (event is FetchRouteDetails) {
      final RouteResponse route = await routeManagementService.fetchRoute(event.routeId);
      yield RouteDetailsState(type: RouteDetailsStateType.route_fetched, route: route);
    } else if (event is UpdateRouteStatus) {
      yield RouteDetailsState(type: RouteDetailsStateType.loading, route: state.route);
      final ResourceOperationResponse response =
          await routeManagementService.updateRouteStatus(event.routeId, event.status);
      final RouteResponse route = await routeManagementService.fetchRoute(response.id);
      yield RouteDetailsState(type: RouteDetailsStateType.route_fetched, route: route);
    } else if (event is UpdateDropStatus) {
      yield RouteDetailsState(type: RouteDetailsStateType.loading, route: state.route);
      final ResourceOperationResponse response =
          await routeManagementService.updateDropStatus(event.dropUid, event.status, event.delayDuration);
      final RouteResponse route = await routeManagementService.fetchRoute(state.route.id);
      yield RouteDetailsState(type: RouteDetailsStateType.route_fetched, route: route);
    }
  }
}
