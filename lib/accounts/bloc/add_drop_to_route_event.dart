part of 'add_drop_to_route_bloc.dart';

abstract class AddDropToRouteEvent extends Equatable {
  const AddDropToRouteEvent();
}

class FormChanged extends AddDropToRouteEvent {
  final RouteDropRequest drop;

  FormChanged({this.drop});

  @override
  List<Object> get props => [drop];
}

class FormSubmitted extends AddDropToRouteEvent {
  final RouteDropRequest drop;

  FormSubmitted({this.drop});

  @override
  List<Object> get props => [drop];
}
