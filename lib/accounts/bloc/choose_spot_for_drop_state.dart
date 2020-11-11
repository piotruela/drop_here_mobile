part of 'choose_spot_for_drop_bloc.dart';

class ChooseSpotForDropState extends Equatable {
  final List<SpotCompanyResponse> spots;
  final SpotCompanyResponse selectedSpot;
  final ChooseSpotForDropStateType type;

  const ChooseSpotForDropState({this.spots, this.selectedSpot, this.type});

  ChooseSpotForDropState copyWith({spots, radioValue}) {
    return ChooseSpotForDropState(spots: spots ?? this.spots, selectedSpot: selectedSpot ?? this.selectedSpot);
  }

  @override
  List<Object> get props => [spots, selectedSpot];
}

enum ChooseSpotForDropStateType { initial, loading, spots_fetched, spot_changed }
