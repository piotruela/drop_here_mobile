part of 'registration_bloc.dart';

class RegistrationFormState extends Equatable {
  const RegistrationFormState({
    this.mail,
    this.password,
    this.passwordRepeat,
    this.isValid,
    this.accountType
  });

  final String mail;
  final String password;
  final String passwordRepeat;
  final bool isValid;
  final AccountType accountType;

  RegistrationFormState copyWith({
    String mail,
    String password,
    String passwordRepeat,
    bool isValid,
    AccountType accountType,
  }) {
    return RegistrationFormState(
      mail: mail ?? this.mail,
      password: password ?? this.password,
      passwordRepeat: passwordRepeat ?? this.passwordRepeat,
      isValid: isValid ?? this.isValid,
      accountType: accountType ?? this.accountType
    );
  }

  @override
  List<Object> get props => [mail, password, passwordRepeat, isValid, accountType];
}