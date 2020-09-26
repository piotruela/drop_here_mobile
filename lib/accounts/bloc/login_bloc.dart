import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/services/authentication_service.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginBloc() : super(LoginFormState(mail: null, password: null, isValid: false));
  final AuthenticationService authenticationService = AuthenticationService("/authentication");


  @override
  Stream<LoginFormState> mapEventToState(
      LoginFormEvent event,
  ) async* {
    if(event is MailChanged){
      final mail = event.mail;
      yield state.copyWith(mail: mail);
    }
    else if (event is PasswordChanged){
      final password = event.password;
      yield state.copyWith(password: password);
    }
    else if (event is LoginFormSubmitted){
      if(event.isValid){
        authenticationService.authenticate(LoginCredentials(mail: state.mail,
            password: state.mail));
      }
    }
  }
}
//"maszkamszota@gmail.com"
//"abcd213123"