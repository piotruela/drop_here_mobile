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
