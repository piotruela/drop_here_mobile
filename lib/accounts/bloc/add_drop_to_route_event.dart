part of 'add_drop_to_route_bloc.dart';

abstract class AddDropToRouteEvent extends Equatable {
  const AddDropToRouteEvent();
}

class FormChanged extends AddDropToRouteEvent {
  final LocalDrop drop;
  final SpotCompanyResponse spot;

  FormChanged({this.drop, this.spot});

  @override
  List<Object> get props => [drop, spot];
}

class FormSubmitted extends AddDropToRouteEvent {
  final LocalDrop drop;

  FormSubmitted({this.drop});

  @override
  List<Object> get props => [drop];
}
