import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/services/account_service.dart';
import 'package:drop_here_mobile/spots/ui/pages/customer_map_page.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'client_details_registration_event.dart';
part 'client_details_registration_state.dart';

class ClientDetailsRegistrationBloc
    extends Bloc<ClientDetailRegistrationEvent, ClientDetailRegistrationState> {
  ClientDetailsRegistrationBloc()
      : super(ClientDetailRegistrationState(type: ClientDetailRegistrationStateType.initial));
  final AccountService accountService = Get.find<AccountService>();
  @override
  Stream<ClientDetailRegistrationState> mapEventToState(
    ClientDetailRegistrationEvent event,
  ) async* {
    if (event is ChangeForm) {
      yield ClientDetailRegistrationState(type: ClientDetailRegistrationStateType.form_changed);
    } else if (event is AddPhoto) {
      yield ClientDetailRegistrationState(type: ClientDetailRegistrationStateType.form_changed);
    } else if (event is SubmitForm) {
      AccountProfileUpdateRequest request =
          AccountProfileUpdateRequest(state.firstName, state.lastName);
      void updateResponse = await accountService.updateProfile(request);
      void photoResponse = await accountService.uploadProfilePhoto(state.photo);
      Get.to(CustomerMapPage());
    }
  }
}
