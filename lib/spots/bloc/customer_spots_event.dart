part of 'customer_spots_bloc.dart';

abstract class CustomerSpotsEvent {}

class FetchSpotsEvent extends CustomerSpotsEvent {
  final int radius;
  final double xCoordinate;
  final double yCoordinate;

  FetchSpotsEvent({this.radius, this.xCoordinate, this.yCoordinate});
}

class SendSpotJoiningRequest extends CustomerSpotsEvent {
  final String spotUid;
  final String companyUid;
  final SpotJoinRequest request;
  SendSpotJoiningRequest({this.spotUid, this.companyUid, this.request});
}
