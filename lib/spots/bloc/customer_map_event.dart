part of 'customer_map_bloc.dart';

abstract class CustomerMapEvent {}

class FetchSpotsEvent extends CustomerMapEvent {
  final int radius;
  final double xCoordinate;
  final double yCoordinate;

  FetchSpotsEvent({this.radius, this.xCoordinate, this.yCoordinate});
}

class FetchSpotDetailsEvent extends CustomerMapEvent {
  final String spotUid;

  FetchSpotDetailsEvent({this.spotUid});
}
