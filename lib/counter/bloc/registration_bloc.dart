import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/counter/services/registration_service.dart';
import 'package:equatable/equatable.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationFormEvent, RegistrationFormState> {
  final RegistrationService registrationService = RegistrationService(path: "/accounts");
  RegistrationBloc() : super(RegistrationFormState(mail: null, password: null, isValid: false));


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
          registrationService.register(RegistrationCredentials(mail: state.mail, password: state.password,
              accountType: event.accountType));
      }
    }
  }
}
