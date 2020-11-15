part of 'routes_list_bloc.dart';

class RoutesListState extends Equatable {
  final RoutesListStateType type;
  final RoutePage routePage;

  const RoutesListState({this.type, this.routePage});

  @override
  List<Object> get props => [type, routePage];
}

enum RoutesListStateType {
  initial,
  routes_fetched,
  route_deleted,
}
