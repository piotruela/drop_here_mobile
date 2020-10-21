part of 'add_route_bloc.dart';

abstract class AddRouteEvent extends Equatable {
  const AddRouteEvent();
}

class FormChanged extends AddRouteEvent {
  final UnpreparedRouteRequest routeRequest;

  FormChanged({this.routeRequest});

  @override
  List<Object> get props => [routeRequest];
}

class FormSubmitted extends AddRouteEvent {
  final UnpreparedRouteRequest routeRequest;

  FormSubmitted({this.routeRequest});

  @override
  List<Object> get props => [routeRequest];
}

class AddDate extends AddRouteEvent {
  final UnpreparedRouteRequest routeRequest;
  final DateTime pickedDate;
  const AddDate({this.routeRequest, this.pickedDate});
  @override
  List<Object> get props => [routeRequest, pickedDate];
}
