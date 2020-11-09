part of 'add_drop_to_route_bloc.dart';

class AddDropToRouteFormState extends Equatable {
  final LocalDrop drop;
  final SpotCompanyResponse spot;
  const AddDropToRouteFormState({this.drop, this.spot});

  AddDropToRouteFormState copyWith({
    final LocalDrop drop,
    final SpotCompanyResponse spot,
  }) {
    return AddDropToRouteFormState(
      drop: drop ?? this.drop,
      spot: spot ?? this.spot,
    );
  }

  bool get isFilled =>
      drop.name != null && spot != null && drop.startTime != null && drop.endTime != null;

  @override
  List<Object> get props => [drop, spot, isFilled];
}
