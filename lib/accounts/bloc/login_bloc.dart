import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/credentials.dart';
import 'package:drop_here_mobile/accounts/services/authentication_service.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginBloc() : super(LoginFormState(form: LoginCredentials()));
  final AuthenticationService authenticationService = AuthenticationService();

  @override
  Stream<LoginFormState> mapEventToState(
    LoginFormEvent event,
  ) async* {
    if (event is FormChanged) {
      final form = event.form;
      yield state.copyWith(form: form);
    } else if (event is FormSubmitted) {
      yield LoginLoadingState();
      if (event.isValid) {
        AuthenticationResult result = await authenticationService.authenticate(event.form);
        if (result == AuthenticationResult.success) {
          yield SuccessState();
        } else {
          yield ErrorState();
        }
      }
    }
  }
}
