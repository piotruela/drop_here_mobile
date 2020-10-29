part of 'spots_list_bloc.dart';

class SpotsMapState extends Equatable {
  const SpotsMapState();

  @override
  List<Object> get props => [];
}

class SpotsFetched extends SpotsMapState {
  final List<SpotCompanyResponse> spots;

  SpotsFetched({this.spots});

  @override
  List<Object> get props => [spots];
}

class SpotDeleted extends SpotsMapState {
  final List<SpotCompanyResponse> spots;

  SpotDeleted({this.spots});

  @override
  List<Object> get props => [spots];
}

class SpotDetailsPanelCreated extends SpotsMapState {
  final SlidingUpPanel spotDetailsPanel;

  SpotDetailsPanelCreated({this.spotDetailsPanel});

  @override
  List<Object> get props => [spotDetailsPanel];
}

class SpotDetailsPanelClosed extends SpotsMapState {
  final SlidingUpPanel spotDetailsPanel;

  SpotDetailsPanelClosed({this.spotDetailsPanel});

  @override
  List<Object> get props => [spotDetailsPanel];
}
