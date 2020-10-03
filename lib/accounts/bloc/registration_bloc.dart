import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/authentication_api.dart';
import 'package:drop_here_mobile/accounts/services/account_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegisterEvent, RegisterState> {
  final AccountService accountService = Get.find<AccountService>();
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
      RegisterLoadingState();
      if (event.isValid) {
        LoginResponse result = await accountService.register(event.form);
        if (result.token != '-1') {
          yield state.copyWith(success: true);
        } else {
          yield state.copyWith(success: false);
        }
      }
    }
  }
}
