part of 'add_spot_bloc.dart';

abstract class AddSpotEvent extends Equatable {
  const AddSpotEvent();
}

class FormChanged extends AddSpotEvent {
  final SpotManagementRequest spotManagementRequest;

  FormChanged({this.spotManagementRequest});

  @override
  List<Object> get props => [spotManagementRequest];
}

class FormSubmitted extends AddSpotEvent {
  final SpotManagementRequest spotManagementRequest;

  FormSubmitted({this.spotManagementRequest});

  @override
  List<Object> get props => [spotManagementRequest];
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
