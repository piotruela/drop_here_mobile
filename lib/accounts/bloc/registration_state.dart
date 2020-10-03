part of 'registration_bloc.dart';

class RegisterState extends Equatable {
  final AccountCreationRequest form;
  final bool success;

  const RegisterState({this.form, this.success});

  RegisterState copyWith({AccountCreationRequest form, bool success, bool successNull = false}) {
    return RegisterState(
        form: form ?? this.form, success: successNull ? null : success ?? this.success);
  }

  @override
  List<Object> get props => [form, success];
}

class RegisterLoadingState extends RegisterState {}
