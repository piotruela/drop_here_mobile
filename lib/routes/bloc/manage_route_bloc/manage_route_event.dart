part of 'manage_route_bloc.dart';

abstract class ManageRouteEvent extends Equatable {
  const ManageRouteEvent();
}

class InitializeForm extends ManageRouteEvent {
  final UnpreparedRouteRequest routeRequest;
  final List<ProductResponse> alreadyAddedProducts;

  InitializeForm({this.routeRequest, this.alreadyAddedProducts});

  @override
  List<Object> get props => [routeRequest];
}

class FormChanged extends ManageRouteEvent {
  final UnpreparedRouteRequest routeRequest;

  FormChanged({this.routeRequest});

  @override
  List<Object> get props => [routeRequest];
}

class RemoveProduct extends ManageRouteEvent {
  final int productId;

  RemoveProduct({this.productId});

  @override
  List<Object> get props => [productId];
}

class AddDrop extends ManageRouteEvent {
  final RouteDropRequest drop;

  AddDrop({this.drop});

  @override
  List<Object> get props => [drop];
}

class RemoveDrop extends ManageRouteEvent {
  final RouteDropRequest drop;

  RemoveDrop({this.drop});

  @override
  List<Object> get props => [drop];
}

class FormSubmitted extends ManageRouteEvent {
  final UnpreparedRouteRequest request;
  final int routeId;

  FormSubmitted({this.request, this.routeId});

  @override
  List<Object> get props => [];
}
