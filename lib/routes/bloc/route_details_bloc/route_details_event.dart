part of 'route_details_bloc.dart';

abstract class RouteDetailsEvent extends Equatable {
  const RouteDetailsEvent();
}

class FetchRouteDetails extends RouteDetailsEvent {
  final int routeId;

  FetchRouteDetails({this.routeId});
  @override
  List<Object> get props => [routeId];
}

class UpdateRouteStatus extends RouteDetailsEvent {
  final int routeId;
  final RouteStatus status;

  UpdateRouteStatus({this.routeId, this.status});
  @override
  List<Object> get props => [routeId, status];
}

class UpdateDropStatus extends RouteDetailsEvent {
  final String dropUid;
  final DropStatus status;
  final int delayDuration;

  UpdateDropStatus({this.dropUid, this.status, this.delayDuration});
  @override
  List<Object> get props => [dropUid, status, delayDuration];
}
