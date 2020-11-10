part of 'create_order_bloc.dart';

class CreateOrderState extends Equatable {
  final CreateOrderStateType type;
  final List<RouteProductRouteResponse> products = [];
  CreateOrderState(this.type);
  @override
  List<Object> get props => [type, products];
}

enum CreateOrderStateType {
  initial,
  form_updated,
}
