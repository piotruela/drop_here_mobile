part of 'add_route_bloc.dart';

abstract class AddRouteEvent extends Equatable {
  const AddRouteEvent();
}

class FormChanged extends AddRouteEvent {
  final UnpreparedRouteRequest routeRequest;
  final String sellerFirstName;
  final String sellerLastName;

  FormChanged({this.routeRequest, this.sellerFirstName, this.sellerLastName});

  @override
  List<Object> get props => [routeRequest, sellerFirstName, sellerLastName];
}

class FormSubmitted extends AddRouteEvent {
  final UnpreparedRouteRequest routeRequest;

  FormSubmitted({this.routeRequest});

  @override
  List<Object> get props => [routeRequest];
}

class AddProducts extends AddRouteEvent {
  final Set<LocalProduct> products;

  AddProducts({this.products});

  @override
  List<Object> get props => [products];
}

class AddDate extends AddRouteEvent {
  final UnpreparedRouteRequest routeRequest;
  final DateTime pickedDate;
  const AddDate({this.routeRequest, this.pickedDate});
  @override
  List<Object> get props => [routeRequest, pickedDate];
}

class DeleteDate extends AddRouteEvent {
  const DeleteDate();
  @override
  List<Object> get props => [];
}

class AddDrop extends AddRouteEvent {
  final LocalDrop drop;
  const AddDrop(this.drop);
  @override
  List<Object> get props => [drop];
}

class RemoveDrop extends AddRouteEvent {
  final LocalDrop drop;
  const RemoveDrop(this.drop);
  @override
  List<Object> get props => [drop];
}
