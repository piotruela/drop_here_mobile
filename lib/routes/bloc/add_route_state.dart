part of 'add_route_bloc.dart';

class AddRouteFormState extends Equatable {
  final UnpreparedRouteRequest routeRequest;
  final List<RouteDropRequest> drops;
  final List<LocalProduct> products;
  const AddRouteFormState({this.routeRequest, this.drops, this.products});

  AddRouteFormState copyWith({
    final UnpreparedRouteRequest routeRequest,
    final List<RouteDropRequest> drops,
    final List<LocalProduct> products,
  }) {
    return AddRouteFormState(
      routeRequest: routeRequest ?? this.routeRequest,
      drops: drops ?? this.drops,
      products: products ?? this.products,
    );
  }

  bool get isFilled =>
      //TODO add more
      routeRequest.name != null && routeRequest.date != null;

  @override
  List<Object> get props => [routeRequest, isFilled, drops, products];
}
