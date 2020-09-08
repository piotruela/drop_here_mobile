part of 'login_bloc.dart';

abstract class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object> get props => [];
}

class FormInitialized extends Equatable {
  final bool isValid;

  FormInitialized({this.isValid});

  @override
  List<Object> get props => [isValid];
}

class MailChanged extends LoginFormEvent{
  final String mail;

  MailChanged({this.mail});

  @override
  List<Object> get props => [mail];
}

class PasswordChanged extends LoginFormEvent{
  final String password;

  PasswordChanged({this.password});

  @override
  List<Object> get props => [password];
}

class LoginFormSubmitted extends LoginFormEvent{
  final String mail;
  final String password;
  final bool isValid;

  LoginFormSubmitted({this.mail, this.password, this.isValid});

  @override
  List<Object> get props => [mail, password, isValid];
}