part of 'spot_details_bloc.dart';

abstract class SpotDetailsEvent extends Equatable {
  const SpotDetailsEvent();
}

class FetchSpotDetails extends SpotDetailsEvent {
  const FetchSpotDetails();

  @override
  List<Object> get props => [];
}
