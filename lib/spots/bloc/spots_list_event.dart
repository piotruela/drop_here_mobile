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
