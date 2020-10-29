import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'route_details_event.dart';
part 'route_details_state.dart';

class RouteDetailsBloc extends Bloc<RouteDetailsEvent, RouteDetailsState> {
  RouteDetailsBloc() : super(RouteDetailsInitial());

  @override
  Stream<RouteDetailsState> mapEventToState(
    RouteDetailsEvent event,
  ) async* {
    yield RouteDetailsInitial();
    if (event is FetchRouteDetails) {
      //TODO implement
      yield RouteDetailsFetched();
    }
  }
}
