part of 'spot_details_bloc.dart';

abstract class SpotDetailsEvent extends Equatable {
  const SpotDetailsEvent();
}

class FetchSpotDetails extends SpotDetailsEvent {
  final SpotCompanyResponse spot;

  const FetchSpotDetails({this.spot});

  @override
  List<Object> get props => [];
}
