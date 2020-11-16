part of 'company_spots_bloc.dart';

abstract class CompanySpotsEvent {}

class FetchSpotsEvent extends CompanySpotsEvent {
  FetchSpotsEvent();
}

class FetchSpotDetailsEvent extends CompanySpotsEvent {
  final String spotId;

  FetchSpotDetailsEvent({this.spotId});
}

class CloseSpotDetailsPanel extends CompanySpotsEvent {
  CloseSpotDetailsPanel();
}

class UpdateMembershipStatus extends CompanySpotsEvent {
  final int spotId;
  final int spotMembershipId;
  final String status;
  UpdateMembershipStatus({this.spotId, this.spotMembershipId, this.status});
}
