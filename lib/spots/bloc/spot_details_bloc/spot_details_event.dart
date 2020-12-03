part of 'spot_details_bloc.dart';

abstract class SpotDetailsEvent {}

class FetchSpotDetailsEvent extends SpotDetailsEvent {
  final String spotUid;

  FetchSpotDetailsEvent({this.spotUid});
}

class CloseSpotDetailsPanel extends SpotDetailsEvent {}

class WrongSpotPassword extends SpotDetailsEvent {}
