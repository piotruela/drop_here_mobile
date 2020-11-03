import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:drop_here_mobile/routes/services/route_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'routes_list_event.dart';
part 'routes_list_state.dart';

class RoutesListBloc extends Bloc<RoutesListEvent, RoutesListState> {
  RoutesListBloc() : super(RoutesListInitial());
  RouteManagementService routeManagementService = Get.find<RouteManagementService>();
  @override
  Stream<RoutesListState> mapEventToState(
    RoutesListEvent event,
  ) async* {
    yield RoutesListInitial();
    if (event is FetchRoutes) {
      RoutePage route = await routeManagementService.fetchRoutes();
      yield RoutesFetched(route);
    } else if (event is DeleteRoute) {
      if(state is RoutesFetched){
        RoutePage routePage = (state as RoutesFetched).routePage;
        final List<RouteShortResponse> updatedRoutes = (state as RoutesFetched).routePage.content.where((route) => route.id.toString() != event.routeId).toList();
        routePage.content = updatedRoutes;
        yield RoutesFetched(routePage);
      }
      routeManagementService.deleteRoute(event.routeId);
      //TODO yield state
      //yield RoutesFetched();
    }
  }
}
