part of 'add_drop_to_route_bloc.dart';

class AddDropToRouteFormState extends Equatable {
  final RouteDropRequest drop;
  final SpotCompanyResponse spot;
  const AddDropToRouteFormState({this.drop, this.spot});

  AddDropToRouteFormState copyWith({
    final RouteDropRequest drop,
    final SpotCompanyResponse spot,
  }) {
    return AddDropToRouteFormState(
      drop: drop ?? this.drop,
      spot: spot ?? this.spot,
    );
  }

  bool get isFilled =>
      //TODO add more
      drop.name != null;

  @override
  List<Object> get props => [drop, spot, isFilled];
}
