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

class RegistrationFormSubmitted extends RegistrationFormEvent{
  final String mail;
  final String password;
  final String passwordRepeat;
  final bool isValid;
  final AccountType accountType;

  RegistrationFormSubmitted({this.mail, this.password, this.isValid, this.passwordRepeat, this.accountType});

  @override
  List<Object> get props => [mail, password, isValid, passwordRepeat, accountType];
}

enum AccountType{
  CUSTOMER,COMPANY
}