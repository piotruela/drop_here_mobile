part of 'client_details_registration_bloc.dart';

abstract class ClientDetailRegistrationEvent extends Equatable {
  const ClientDetailRegistrationEvent();
}

class AddPhoto extends ClientDetailRegistrationEvent {
  @override
  List<Object> get props => [];
}

class ChangeForm extends ClientDetailRegistrationEvent {
  final String firstName;
  final String lastName;

  ChangeForm(this.firstName, this.lastName);
  @override
  List<Object> get props => [firstName, lastName];
}

class SubmitForm extends ClientDetailRegistrationEvent {
  @override
  List<Object> get props => [];
}
