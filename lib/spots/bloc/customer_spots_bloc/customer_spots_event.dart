part of 'customer_spots_bloc.dart';

abstract class CustomerSpotsEvent {}

class FetchSpotsEvent extends CustomerSpotsEvent {
  final int radius;
  final double xCoordinate;
  final double yCoordinate;

  FetchSpotsEvent({this.radius, this.xCoordinate, this.yCoordinate});
}

class FetchSpotDetails extends CustomerSpotsEvent {
  final String spotUid;

  FetchSpotDetails({this.spotUid});
}

class SendSpotJoiningRequest extends CustomerSpotsEvent {
  final String spotUid;
  final String companyUid;
  final SpotJoinRequest request;
  SendSpotJoiningRequest({this.spotUid, this.companyUid, this.request});
}

class UpdateSpotSettings extends CustomerSpotsEvent {
  final String spotUid;
  final String companyUid;
  final SpotMembershipManagementRequest request;
  UpdateSpotSettings({this.spotUid, this.companyUid, this.request});
}

class LeaveSpot extends CustomerSpotsEvent {
  final String spotUid;
  final String companyUid;
  LeaveSpot({this.spotUid, this.companyUid});
}
