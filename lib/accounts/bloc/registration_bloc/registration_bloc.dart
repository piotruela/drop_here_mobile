import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/authentication_api.dart';
import 'package:drop_here_mobile/accounts/services/account_service.dart';
import 'package:drop_here_mobile/accounts/services/authentication_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegisterEvent, RegisterState> {
  final AccountService _accountService = Get.find<AccountService>();
  final AuthenticationService _authenticationService = Get.find<AuthenticationService>();

  RegistrationBloc({@required AccountType accountType})
      : super(RegisterState(form: AccountCreationRequest(accountType: accountType), success: null));

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is FormChanged) {
      final form = event.form;
      yield state.copyWith(form: form, successNull: true);
    } else if (event is FormSubmitted) {
      if (event.isValid) {
        yield RegisterLoadingState();
        try {
          await _accountService.createNewAccount(event.form);
          yield SuccessState(event.form.accountType, RegistrationType.FORM);
        } on Exception {
          yield ErrorState(form: event.form);
        }
      }
    }else if(event is FacebookSigningSubmitted){
      try{
        await _authenticationService.authenticateViaExternalService(ExternalAuthenticationProviderType.FACEBOOK);
        yield SuccessState(AccountType.CUSTOMER, RegistrationType.FACEBOOK);
      } on Exception{
        yield ErrorState(form: new AccountCreationRequest(accountType: AccountType.CUSTOMER, mail: "", password: ""));
      }
    }
  }
}
