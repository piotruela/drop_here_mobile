part of 'login_bloc.dart';

abstract class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object> get props => [];
}

class FormChanged extends LoginFormEvent {
  final LoginCredentials form;

  FormChanged({this.form});

  @override
  List<Object> get props => [form];
}

class FormSubmitted extends LoginFormEvent {
  final bool isValid;
  final LoginCredentials form;

  FormSubmitted({this.isValid, this.form});

  @override
  List<Object> get props => [form, isValid];
}
