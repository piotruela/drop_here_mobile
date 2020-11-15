part of 'login_profile_bloc.dart';

class LoginProfileState extends Equatable {
  final ProfileLoginRequest form;

  const LoginProfileState({this.form});

  LoginProfileState copyWith({ProfileLoginRequest form}) {
    return LoginProfileState(form: form ?? this.form);
  }

  @override
  List<Object> get props => [form];
}

class LoginLoadingState extends LoginProfileState {}

class LoginSucceeded extends LoginProfileState {}

class LoginFailure extends LoginProfileState {
  final ProfileLoginRequest form;

  LoginFailure({this.form});
}
