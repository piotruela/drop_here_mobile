part of 'spots_list_bloc.dart';

class SpotsMapState extends Equatable {
  const SpotsMapState();

  @override
  List<Object> get props => [];
}

class SpotsFetched extends SpotsMapState {
  final List<SpotCompanyResponse> spots;

  SpotsFetched({this.spots});
}

class SpotDeleted extends SpotsMapState {
  final List<SpotCompanyResponse> spots;

  SpotDeleted({this.spots});
}
