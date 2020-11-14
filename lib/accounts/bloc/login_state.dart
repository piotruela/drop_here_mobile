part of 'login_bloc.dart';

class LoginFormState extends Equatable {
  final LoginRequest form;

  const LoginFormState({this.form});

  LoginFormState copyWith({LoginRequest form}) {
    return LoginFormState(form: form ?? this.form);
  }

  @override
  List<Object> get props => [form];
}

class LoginLoadingState extends LoginFormState {}

class ErrorState extends LoginFormState {
  final LoginRequest form;

  ErrorState({this.form});
}

class SuccessState extends LoginFormState {
  final AccountType accountType;

  SuccessState(this.accountType);
}
