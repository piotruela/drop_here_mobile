part of 'login_bloc.dart';

class LoginFormState extends Equatable {
  final LoginRequest form;
  final bool success;

  const LoginFormState({this.form, this.success});

  LoginFormState copyWith({LoginRequest form}) {
    return LoginFormState(form: form ?? this.form, success: success ?? this.success);
  }

  @override
  List<Object> get props => [form];
}

class LoginLoadingState extends LoginFormState {}

class ErrorState extends LoginFormState {}

class SuccessState extends LoginFormState {}
