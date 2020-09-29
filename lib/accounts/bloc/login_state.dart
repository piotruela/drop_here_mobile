part of 'login_bloc.dart';

class LoginFormState extends Equatable {
  final LoginCredentials form;

  const LoginFormState({
    this.form,
  });

  LoginFormState copyWith({LoginCredentials form}) {
    return LoginFormState(
      form: form ?? this.form,
    );
  }

  @override
  List<Object> get props => [form];
}

class CreateProfileLoadingState extends LoginFormState {}

class ErrorState extends LoginFormState {}

class SuccessState extends LoginFormState {}
