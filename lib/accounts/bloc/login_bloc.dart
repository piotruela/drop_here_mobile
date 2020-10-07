import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/authentication_api.dart';
import 'package:drop_here_mobile/accounts/services/authentication_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginBloc() : super(LoginFormState(form: LoginRequest()));
  final AuthenticationService authenticationService = Get.find<AuthenticationService>()
    ..logOutFromAccount();

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
        LoginResponse loginResponse = await authenticationService.authenticate(event.form);
        if (loginResponse.token != "-1") {
          yield SuccessState();
        } else {
          yield ErrorState();
        }
      }
    }
  }
}
