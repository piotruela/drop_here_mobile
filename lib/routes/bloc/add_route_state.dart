part of 'add_route_bloc.dart';

class AddRouteFormState extends Equatable {
  final UnpreparedRouteRequest routeRequest;
  const AddRouteFormState({
    this.routeRequest,
  });

  AddRouteFormState copyWith({
    final UnpreparedRouteRequest routeRequest,
  }) {
    return AddRouteFormState(
      routeRequest: routeRequest ?? this.routeRequest,
    );
  }

  bool get isFilled =>
      //TODO add more
      routeRequest.name != null && routeRequest.date != null;

  @override
  List<Object> get props => [routeRequest, isFilled];
}
