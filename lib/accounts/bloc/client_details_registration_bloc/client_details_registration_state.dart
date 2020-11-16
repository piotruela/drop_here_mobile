part of 'client_details_registration_bloc.dart';

class ClientDetailRegistrationState extends Equatable {
  final String firstName;
  final String lastName;
  final File photo;
  final ClientDetailRegistrationStateType type;

  const ClientDetailRegistrationState({this.firstName, this.lastName, this.photo, this.type});

  ClientDetailRegistrationState copyWith({
    String firstName,
    String lastName,
    File photo,
    ClientDetailRegistrationStateType type,
  }) {
    return ClientDetailRegistrationState(
      type: type ?? this.type,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      photo: photo ?? this.photo,
    );
  }

  @override
  List<Object> get props => [firstName, lastName, photo, type];
}

enum ClientDetailRegistrationStateType {
  initial,
  form_changed,
  error,
}
