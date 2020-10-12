part of 'add_spot_bloc.dart';

abstract class AddSpotEvent extends Equatable {
  const AddSpotEvent();
}

class FormChanged extends AddSpotEvent {
  final File locationMap;
  final SpotManagementRequest spotManagementRequest;

  FormChanged({this.spotManagementRequest, this.locationMap});

  @override
  List<Object> get props => [spotManagementRequest, locationMap];
}

class FormSubmitted extends AddSpotEvent {
  final File locationMap;
  final SpotManagementRequest spotManagementRequest;

  FormSubmitted({this.spotManagementRequest, this.locationMap});

  @override
  List<Object> get props => [spotManagementRequest, locationMap];
}

class AddLocation extends AddSpotEvent {
  const AddLocation();
  @override
  List<Object> get props => [];
}

class AddRoute extends AddSpotEvent {
  const AddRoute();
  @override
  List<Object> get props => [];
}

class AddMember extends AddSpotEvent {
  const AddMember();
  @override
  List<Object> get props => [];
}
