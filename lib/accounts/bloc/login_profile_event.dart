part of 'login_profile_bloc.dart';

abstract class LoginProfileEvent extends Equatable {
  LoginProfileEvent();

  @override
  List<Object> get props => [];
}

class FormChanged extends LoginProfileEvent {
  final ProfileLoginRequest form;

  FormChanged({this.form});

  @override
  List<Object> get props => [form];
}

class FormSubmitted extends LoginProfileEvent {
  final bool isValid;
  final ProfileLoginRequest form;

  FormSubmitted({this.isValid, this.form});

  @override
  List<Object> get props => [form, isValid];
}
