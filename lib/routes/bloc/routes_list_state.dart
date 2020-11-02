part of 'routes_list_bloc.dart';

abstract class RoutesListState extends Equatable {
  const RoutesListState();
}

class RoutesListInitial extends RoutesListState {
  @override
  List<Object> get props => [];
}

class RoutesFetched extends RoutesListState {
  final RoutePage routePage;

  RoutesFetched(this.routePage);
  @override
  List<Object> get props => [routePage];
}
