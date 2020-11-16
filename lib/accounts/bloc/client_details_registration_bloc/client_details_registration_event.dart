part of 'client_details_registration_bloc.dart';

abstract class ClientDetailRegistrationEvent extends Equatable {
  const ClientDetailRegistrationEvent();
}

class AddPhoto extends ClientDetailRegistrationEvent {
  @override
  List<Object> get props => [];
}

class ChangeForm extends ClientDetailRegistrationEvent {
  @override
  List<Object> get props => [];
}

class SubmitForm extends ClientDetailRegistrationEvent {
  @override
  List<Object> get props => [];
}
