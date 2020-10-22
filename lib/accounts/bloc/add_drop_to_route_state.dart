part of 'add_drop_to_route_bloc.dart';

class AddDropToRouteFormState extends Equatable {
  final RouteDropRequest drop;
  const AddDropToRouteFormState({this.drop});

  AddDropToRouteFormState copyWith({
    final RouteDropRequest drop,
  }) {
    return AddDropToRouteFormState(
      drop: drop ?? this.drop,
    );
  }

  bool get isFilled =>
      //TODO add more
      drop.name != null && drop.startTime != null;

  @override
  List<Object> get props => [drop, isFilled];
}
