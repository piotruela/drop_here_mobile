part of 'login_bloc.dart';

class LoginFormState extends Equatable {
  const LoginFormState({
    this.mail,
    this.password,
    this.isValid,
  });

  final String mail;
  final String password;
  final bool isValid;

  LoginFormState copyWith({
    String mail,
    String password,
    bool isValid,
  }) {
    return LoginFormState(
      mail: mail ?? this.mail,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [mail, password, isValid];
}