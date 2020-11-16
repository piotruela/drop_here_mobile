part of 'routes_list_bloc.dart';

abstract class RoutesListEvent extends Equatable {
  const RoutesListEvent();
}

class FetchRoutes extends RoutesListEvent {
  const FetchRoutes();

  @override
  List<Object> get props => [];
}

class DeleteRoute extends RoutesListEvent {
  final String routeId;
  const DeleteRoute(this.routeId);

  @override
  List<Object> get props => [routeId];
}
