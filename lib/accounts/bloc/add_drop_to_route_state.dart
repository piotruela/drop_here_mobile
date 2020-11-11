part of 'add_drop_to_route_bloc.dart';

class AddDropToRouteFormState extends Equatable {
  final RouteDropRequest drop;
  final List<SpotCompanyResponse> spots;
  final SpotCompanyResponse selectedSpot;
  const AddDropToRouteFormState({this.drop, this.spots, this.selectedSpot});

  AddDropToRouteFormState copyWith({
    final RouteDropRequest drop,
    final List<SpotCompanyResponse> spots,
    final SpotCompanyResponse selectedSpot,
  }) {
    return AddDropToRouteFormState(
        drop: drop ?? this.drop, spots: spots ?? this.spots, selectedSpot: selectedSpot ?? this.selectedSpot);
  }

  bool get isFilled =>
      drop?.name != null && drop?.name != "" && selectedSpot != null && drop.startTime != null && drop.endTime != null;

  @override
  List<Object> get props => [drop, spots, selectedSpot];
}
