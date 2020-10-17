part of 'spots_list_bloc.dart';

abstract class SpotsListEvent extends Equatable {
  const SpotsListEvent();
}

class FetchSpots extends SpotsListEvent {
  @override
  List<Object> get props => [];
}
