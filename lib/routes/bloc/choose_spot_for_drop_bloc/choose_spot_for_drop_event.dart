part of 'choose_spot_for_drop_bloc.dart';

abstract class ChooseSpotForDropEvent extends Equatable {
  const ChooseSpotForDropEvent();
}

class AddSpotToDropPageEntered extends ChooseSpotForDropEvent {
  final SpotCompanyResponse selectedSpot;

  AddSpotToDropPageEntered({this.selectedSpot});

  @override
  List<Object> get props => [];
}

class SelectSpot extends ChooseSpotForDropEvent {
  final SpotCompanyResponse spot;
  SelectSpot({this.spot});

  @override
  List<Object> get props => [spot];
}
