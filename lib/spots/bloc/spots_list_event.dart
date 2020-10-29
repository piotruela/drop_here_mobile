part of 'spots_list_bloc.dart';

abstract class SpotsMapEvent extends Equatable {
  const SpotsMapEvent();
}

class FetchSpots extends SpotsMapEvent {
  final List<SpotCompanyResponse> spots;

  FetchSpots({this.spots});

  @override
  List<Object> get props => [];
}

class DeleteSpot extends SpotsMapEvent {
  final int spotId;

  DeleteSpot({this.spotId});

  @override
  List<Object> get props => [spotId];
}

class SpotPinClicked extends SpotsMapEvent {
  final SpotCompanyResponse spot;
  final BuildContext context;

  SpotPinClicked({this.spot, this.context});

  @override
  List<Object> get props => [spot];
}

class SpotPanelClosed extends SpotsMapEvent {
  @override
  List<Object> get props => [];
}
