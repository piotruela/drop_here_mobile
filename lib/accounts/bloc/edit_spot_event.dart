part of 'edit_spot_bloc.dart';

abstract class EditSpotEvent extends Equatable {
  const EditSpotEvent();
}

class FormChanged extends EditSpotEvent {
  final File locationMap;
  final SpotManagementRequest spot;

  FormChanged({this.locationMap, this.spot});

  @override
  List<Object> get props => [locationMap, spot];
}

class FormSubmitted extends EditSpotEvent {
  final File locationMap;
  final SpotManagementRequest spotManagementRequest;

  FormSubmitted({this.locationMap, this.spotManagementRequest});

  @override
  List<Object> get props => [locationMap, spotManagementRequest];
}
