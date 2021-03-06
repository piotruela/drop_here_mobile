import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
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
        try {
          await authenticationService.authenticate(event.form);
          AuthenticationResponse response = await authenticationService.authenticationInfo();
          yield SuccessState(response.accountType);
        } on Exception {
          yield ErrorState(form: event.form);
        }
      } else {
        yield ErrorState(form: event.form);
      }
    } else if (event is FacebookSigningSubmitted) {
      try {
        await authenticationService
            .authenticateViaExternalService(ExternalAuthenticationProviderType.FACEBOOK);
        yield SuccessState(AccountType.CUSTOMER);
      } on Exception {
        yield ErrorState(form: LoginRequest(mail: "", password: ""));
      }
    }
  }
}
