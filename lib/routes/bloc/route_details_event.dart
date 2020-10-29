part of 'route_details_bloc.dart';

abstract class RouteDetailsEvent extends Equatable {
  const RouteDetailsEvent();
}

class FetchRouteDetails extends RouteDetailsEvent {
  final int routeId;

  FetchRouteDetails(this.routeId);
  @override
  List<Object> get props => [routeId];
}
