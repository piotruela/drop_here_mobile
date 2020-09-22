part of 'registration_bloc.dart';

abstract class RegistrationFormEvent extends Equatable {
  const RegistrationFormEvent();

  @override
  List<Object> get props => [];
}

class FormInitialized extends Equatable {
  final bool isValid;
  final AccountType accountType;

  FormInitialized({this.isValid = false, this.accountType});

  @override
  List<Object> get props => [isValid];
}

class MailChanged extends RegistrationFormEvent{
  final String mail;

  MailChanged({this.mail});

  @override
  List<Object> get props => [mail];
}

class PasswordChanged extends RegistrationFormEvent{
  final String password;

  PasswordChanged({this.password});

  @override
  List<Object> get props => [password];
}

class PasswordRepeatChanged extends RegistrationFormEvent{
  final String passwordRepeat;

  PasswordRepeatChanged({this.passwordRepeat});

  @override
  List<Object> get props => [passwordRepeat];
}

class RegistrationFormSubmitted extends RegistrationFormEvent{
  final bool isValid;
  final AccountType accountType;

  RegistrationFormSubmitted({this.isValid, this.accountType});

  @override
  List<Object> get props => [ isValid, accountType];
}

enum AccountType{
  CUSTOMER,COMPANY
}