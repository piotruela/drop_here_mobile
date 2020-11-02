part of 'routes_list_bloc.dart';

abstract class RoutesListEvent extends Equatable {
  const RoutesListEvent();
}

class FetchRoutes extends RoutesListEvent {
  const FetchRoutes();

  @override
  List<Object> get props => [];
}
