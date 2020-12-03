part of 'edit_spot_bloc.dart';

abstract class EditSpotEvent extends Equatable {
  const EditSpotEvent();
}

class FormChanged extends EditSpotEvent {
  final SpotManagementRequest spot;

  FormChanged({this.spot});

  @override
  List<Object> get props => [spot];
}

class LocationChanged extends EditSpotEvent {
  final SpotManagementRequest spot;
  final LocationResult locationResult;

  LocationChanged({this.spot, this.locationResult});

  @override
  List<Object> get props => [spot, locationResult];
}

class FormSubmitted extends EditSpotEvent {
  final SpotManagementRequest spot;

  FormSubmitted({this.spot});

  @override
  List<Object> get props => [spot];
}
