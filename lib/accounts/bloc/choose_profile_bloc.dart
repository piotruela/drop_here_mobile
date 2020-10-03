import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import 'file:///E:/Piotr%20Maszota/inzynierka/drop_here_mobile/lib/accounts/services/account_service.dart';

part 'choose_profile_event.dart';
part 'choose_profile_state.dart';

class ChooseProfileBloc extends Bloc<ChooseProfileEvent, ChooseProfileState> {
  AccountService _accountService = Get.find<AccountService>();
  ChooseProfileBloc() : super(ChooseProfileInitial());

  @override
  Stream<ChooseProfileState> mapEventToState(
    ChooseProfileEvent event,
  ) async* {
    if (event is FetchProfiles) {
      List<ProfileInfoResponse> profiles = await _accountService.fetchProfiles();
      yield ProfilesFetched(profiles);
    }
  }
}
