import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import 'file:///E:/Piotr%20Maszota/inzynierka/drop_here_mobile/lib/accounts/services/account_service.dart';

part 'create_profile_event.dart';
part 'create_profile_state.dart';

class CreateProfileBloc extends Bloc<CreateProfileEvent, CreateProfileState> {
  final AccountService accountsService = Get.find<AccountService>();
  CreateProfileBloc() : super(CreateProfileState(form: AccountProfileCreationRequest()));

  @override
  Stream<CreateProfileState> mapEventToState(
    CreateProfileEvent event,
  ) async* {
    if (event is FormChanged) {
      AccountProfileCreationRequest form = event.form;
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
