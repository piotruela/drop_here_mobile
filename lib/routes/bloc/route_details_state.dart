part of 'route_details_bloc.dart';

abstract class RouteDetailsState extends Equatable {
  const RouteDetailsState();
}

class RouteDetailsInitial extends RouteDetailsState {
  @override
  List<Object> get props => [];
}

class RouteDetailsFetched extends RouteDetailsState {
  final RouteResponse route;

  RouteDetailsFetched(this.route);
  @override
  List<Object> get props => [];
}
