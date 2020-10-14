part of 'edit_spot_bloc.dart';

abstract class EditSpotEvent extends Equatable {
  const EditSpotEvent();
}

class FormChanged extends EditSpotEvent {
  final File photo;
  final SpotManagementRequest spot;

  FormChanged({this.photo, this.spot});

  @override
  List<Object> get props => [photo, spot];
}

class FormSubmitted extends EditSpotEvent {
  final File photo;
  final SpotManagementRequest spotManagementRequest;

  FormSubmitted({this.photo, this.spotManagementRequest});

  @override
  List<Object> get props => [photo, spotManagementRequest];
}
