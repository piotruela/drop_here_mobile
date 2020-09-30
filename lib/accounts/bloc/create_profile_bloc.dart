import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/company/create_profile_form.dart';
import 'package:drop_here_mobile/accounts/services/account_service.dart';
import 'package:drop_here_mobile/accounts/services/implementation/dh_account_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'create_profile_event.dart';
part 'create_profile_state.dart';

class CreateProfileBloc extends Bloc<CreateProfileEvent, CreateProfileState> {
  final AccountsService accountsService = Get.find<DropHereAccountService>();
  CreateProfileBloc() : super(CreateProfileState(form: CreateProfileForm()));

  @override
  Stream<CreateProfileState> mapEventToState(
    CreateProfileEvent event,
  ) async* {
    if (event is FormChanged) {
      CreateProfileForm form = event.form;
      yield state.copyWith(form: form);
    } else if (event is FormSubmitted) {
      yield CreateProfileLoadingState();
      int result = await accountsService.createProfile(event.form);
      if (result == 1) {
        yield SuccessState();
      } else {
        yield ErrorState();
      }
    }
  }
}
