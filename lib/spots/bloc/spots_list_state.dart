part of 'spots_list_bloc.dart';

abstract class SpotsListState extends Equatable {
  const SpotsListState();
}

class SpotsListInitial extends SpotsListState {
  @override
  List<Object> get props => [];
}

class SpotsFetched extends SpotsListState {
  final List<SpotCompanyResponse> spots;

  SpotsFetched({this.spots});

  @override
  List<Object> get props => [spots];
}
