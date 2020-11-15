import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:drop_here_mobile/routes/services/route_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'routes_list_event.dart';
part 'routes_list_state.dart';

class RoutesListBloc extends Bloc<RoutesListEvent, RoutesListState> {
  RoutesListBloc() : super(RoutesListState(type: RoutesListStateType.initial));
  RouteManagementService routeManagementService = Get.find<RouteManagementService>();
  @override
  Stream<RoutesListState> mapEventToState(
    RoutesListEvent event,
  ) async* {
    if (event is FetchRoutes) {
      RoutePage route = await routeManagementService.fetchRoutes();
      yield RoutesListState(type: RoutesListStateType.routes_fetched, routePage: route);
    } else if (event is DeleteRoute) {
      routeManagementService.deleteRoute(event.routeId);
      RoutePage route = await routeManagementService.fetchRoutes();
      yield RoutesListState(type: RoutesListStateType.routes_fetched, routePage: route);
    }
  }
}
