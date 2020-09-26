import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/credentials.dart';
import 'package:drop_here_mobile/accounts/services/registration_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationFormEvent, RegistrationFormState> {
  final RegistrationService registrationService = RegistrationService();
  RegistrationBloc({@required AccountType accountType}) : super(RegistrationFormState(mail: null, password: null, isValid: false, result: null, accountType: accountType));


  @override
  Stream<RegistrationFormState> mapEventToState(
      RegistrationFormEvent event,
  ) async* {
    if(event is MailChanged){
      final mail = event.mail;
      yield state.copyWith(mail: mail);
    }
    else if (event is PasswordChanged){
      final password = event.password;
      yield state.copyWith(password: password);
    }
    else if (event is PasswordRepeatChanged){
      final passwordRepeat = event.passwordRepeat;
      yield state.copyWith(passwordRepeat: passwordRepeat);
    }
    else if (event is RegistrationFormSubmitted){
      if(event.isValid){
        yield state.copyWith(result: RegistrationResult.in_progress);
          RegistrationResult result = await registrationService.register(RegistrationCredentials(mail: state.mail, password: state.password,
              accountType: event.accountType));
          yield state.copyWith(result: result);
      }
    }
  }
}
