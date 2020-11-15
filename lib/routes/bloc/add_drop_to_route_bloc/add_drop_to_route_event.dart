part of 'add_drop_to_route_bloc.dart';

abstract class AddDropToRouteEvent extends Equatable {
  const AddDropToRouteEvent();
}

class CreateDropPageEntered extends AddDropToRouteEvent {
  final RouteDropRequest drop;

  CreateDropPageEntered({this.drop});

  @override
  List<Object> get props => [drop];
}

class SpotSelected extends AddDropToRouteEvent {
  final SpotCompanyResponse spot;

  SpotSelected({this.spot});

  @override
  List<Object> get props => [spot];
}

class SpotRemoved extends AddDropToRouteEvent {
  SpotRemoved();
  @override
  List<Object> get props => [];
}

class FormChanged extends AddDropToRouteEvent {
  final RouteDropRequest drop;

  FormChanged({this.drop});

  @override
  List<Object> get props => [drop];
}

class FormSubmitted extends AddDropToRouteEvent {
  FormSubmitted();

  @override
  List<Object> get props => [];
}
