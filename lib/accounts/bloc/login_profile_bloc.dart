import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/authentication_api.dart';
import 'package:drop_here_mobile/accounts/services/authentication_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'login_profile_event.dart';
part 'login_profile_state.dart';

class LoginProfileBloc extends Bloc<LoginProfileEvent, LoginProfileState> {
  final AuthenticationService authenticationService = Get.find<AuthenticationService>();
  LoginProfileBloc({@required String profileUid})
      : super(LoginProfileState(form: ProfileLoginRequest(profileUid: profileUid)));

  @override
  Stream<LoginProfileState> mapEventToState(
    LoginProfileEvent event,
  ) async* {
    if (event is FormChanged) {
      final form = event.form;
      yield state.copyWith(form: form);
    } else if (event is FormSubmitted) {
      yield LoginLoadingState();
      if (event.isValid) {
        try {
          await authenticationService.loginToProfile(event.form);
          yield LoginSucceeded();
        } on Exception catch (e) {
          yield LoginFailure(form: event.form);
        }
      } else {
        yield LoginFailure(form: event.form);
      }
    }
  }
}
