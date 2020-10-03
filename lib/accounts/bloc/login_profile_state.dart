part of 'login_profile_bloc.dart';

class LoginProfileState extends Equatable {
  final ProfileLoginRequest form;
  final bool success;

  const LoginProfileState({this.form, this.success});

  LoginProfileState copyWith({ProfileLoginRequest form, bool success, bool successNull = false}) {
    return LoginProfileState(
        form: form ?? this.form, success: successNull ? null : success ?? this.success);
  }

  @override
  List<Object> get props => [form, success];
}

class LoginLoadingState extends LoginProfileState {}
