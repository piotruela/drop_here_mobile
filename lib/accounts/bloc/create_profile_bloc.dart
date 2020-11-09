import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/services/account_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

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
      yield LoadingState();
      var creatingProfileFunction = event.profileRole == ProfileRole.ADMIN
          ? () => accountsService.createAdminProfile(event.form)
          : () => accountsService.createBasicProfile(event.form);
      try {
        await creatingProfileFunction.call();
        yield SuccessState();
      } on Exception {
        yield ErrorState(form: event.form);
      }
    }
  }
}
