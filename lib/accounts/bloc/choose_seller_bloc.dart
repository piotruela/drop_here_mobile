import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'choose_seller_event.dart';
part 'choose_seller_state.dart';

class ChooseSellerBloc extends Bloc<ChooseSellerEvent, ChooseSellerState> {
  ChooseSellerBloc() : super(ChooseSellerInitial());
  final CompanyManagementService companyManagementService = Get.find<CompanyManagementService>();

  @override
  Stream<ChooseSellerState> mapEventToState(
    ChooseSellerEvent event,
  ) async* {
    yield ChooseSellerInitial();
    if (event is FetchSellers) {
      try {
        List<ProfileInfoResponse> sellers = await companyManagementService.fetchCompanySellers();
        yield SellersFetched(radioValue: 0, sellers: sellers);
      } catch (e) {
        yield SellersFetchingError(e);
      }
    } else if (event is ChangeGroupValue) {
      yield SellersFetched(radioValue: event.groupValue, sellers: event.sellers);
    }
  }
}
