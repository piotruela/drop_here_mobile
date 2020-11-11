part of 'manage_route_bloc.dart';

abstract class ManageRouteEvent extends Equatable {
  const ManageRouteEvent();
}

class InitializeForm extends ManageRouteEvent {
  final UnpreparedRouteRequest routeRequest;

  InitializeForm({this.routeRequest});

  @override
  List<Object> get props => [routeRequest];
}

class FormChanged2 extends ManageRouteEvent {
  final UnpreparedRouteRequest routeRequest;

  FormChanged2({this.routeRequest});

  @override
  List<Object> get props => [routeRequest];
}
