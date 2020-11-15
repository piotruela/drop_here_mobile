part of 'registration_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class FormChanged extends RegisterEvent {
  final AccountCreationRequest form;

  FormChanged({this.form});

  @override
  List<Object> get props => [form];
}

class FormSubmitted extends RegisterEvent {
  final bool isValid;
  final AccountCreationRequest form;

  FormSubmitted({this.isValid, this.form});

  @override
  List<Object> get props => [form, isValid];
}

class FacebookSigningSubmitted extends RegisterEvent {}
