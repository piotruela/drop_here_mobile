class LoginForm{
  final String mail;
  final String password;

  LoginForm({this.mail, this.password});

  LoginForm copyWith({
  String mail,
  String password
  }){
    return LoginForm(
      mail: mail ?? this.mail,
      password:  password ?? this.password
    );
  }
}