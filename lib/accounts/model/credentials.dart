import 'package:json_annotation/json_annotation.dart';

part 'credentials.g.dart';

enum AccountType { CUSTOMER, COMPANY }

@JsonSerializable(includeIfNull: false)
class RegistrationCredentials {
  final AccountType accountType;
  final String mail;
  final String password;

  RegistrationCredentials({this.accountType, this.mail, this.password});

  factory RegistrationCredentials.fromJson(Map<String, dynamic> json) =>
      _$RegistrationCredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$RegistrationCredentialsToJson(this);
}

@JsonSerializable()
class LoginCredentials {
  final String mail;
  final String password;

  LoginCredentials({this.mail, this.password});

  factory LoginCredentials.fromJson(Map<String, dynamic> json) => _$LoginCredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$LoginCredentialsToJson(this);

  LoginCredentials copyWith({String mail, String password}) {
    return LoginCredentials(mail: mail ?? this.mail, password: password ?? this.password);
  }
}
