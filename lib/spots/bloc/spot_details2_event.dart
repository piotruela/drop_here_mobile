part of 'spot_details2_bloc.dart';

abstract class SpotDetails2Event {}

class FetchSpotDetailsEvent extends SpotDetails2Event {
  final String spotUid;

  FetchSpotDetailsEvent({this.spotUid});
}

class CloseSpotDetailsPanel extends SpotDetails2Event {}

class WrongSpotPassword extends SpotDetails2Event {}
