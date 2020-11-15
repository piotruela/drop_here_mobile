part of 'route_details_bloc.dart';

class RouteDetailsState extends Equatable {
  final RouteDetailsStateType type;
  final RouteResponse route;

  RouteDetailsState({this.type, this.route});
  @override
  List<Object> get props => [type, route];
}

enum RouteDetailsStateType { loading, route_fetched }
