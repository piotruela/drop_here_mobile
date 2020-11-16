import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'choose_seller_event.dart';
part 'choose_seller_state.dart';

class ChooseSellerBloc extends Bloc<ChooseSellerEvent, ChooseSellerState> {
  final CompanyManagementService companyManagementService = Get.find<CompanyManagementService>();
  ChooseSellerBloc() : super(ChooseSellerState(type: ChooseSellerStateType.loading));

  @override
  Stream<ChooseSellerState> mapEventToState(
    ChooseSellerEvent event,
  ) async* {
    if (event is InitializePage) {
      yield ChooseSellerState(type: ChooseSellerStateType.loading);
      List<ProfileInfoResponse> sellers = await companyManagementService.fetchCompanySellers();
      yield ChooseSellerState(
          type: ChooseSellerStateType.profiles_fetched, sellers: sellers, selectedProfileUid: event.selectedSellerUid);
    } else if (event is ChooseSeller) {
      yield ChooseSellerState(
          type: ChooseSellerStateType.profiles_fetched, selectedProfileUid: event.sellerUid, sellers: state.sellers);
      yield ChooseSellerState(
          type: ChooseSellerStateType.selected_changed, selectedProfileUid: event.sellerUid, sellers: state.sellers);
    }
  }
}
