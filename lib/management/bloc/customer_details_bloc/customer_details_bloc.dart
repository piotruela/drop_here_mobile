import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/customer_management_api.dart';
import 'package:drop_here_mobile/accounts/services/account_service.dart';
import 'package:drop_here_mobile/accounts/services/authentication_service.dart';
import 'package:drop_here_mobile/accounts/services/customer_management_service.dart';
import 'package:drop_here_mobile/accounts/ui/pages/login_page.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'customer_details_event.dart';
part 'customer_details_state.dart';

class CustomerDetailsBloc extends Bloc<CustomerDetailsEvent, CustomerDetailsState> {
  final AccountService _accountService = Get.find<AccountService>();
  final CustomerManagementService _customerManagementService =
      Get.find<CustomerManagementService>();
  final AuthenticationService _authenticationService = Get.find<AuthenticationService>();
  CustomerDetailsBloc()
      : super(CustomerDetailsState(type: CustomerDetailsStateType.loading, customerInfo: null));

  @override
  Stream<CustomerDetailsState> mapEventToState(
    CustomerDetailsEvent event,
  ) async* {
    if (event is FetchCustomerDetails) {
      CustomerDetailsState(
          type: CustomerDetailsStateType.loading, customerInfo: null, accountInfo: null);
      final CustomerInfoResponse customerInfo = await _customerManagementService.getCustomerInfo();
      final AccountInfoResponse accountInfoResponse = await _accountService.fetchAccountDetails();
      final String photo = await _customerManagementService.getCustomerPhoto();
      yield CustomerDetailsState(
          type: CustomerDetailsStateType.fetched,
          customerInfo: customerInfo,
          accountInfo: accountInfoResponse,
          photo: photo);
    } else if (event is LogOut) {
      CustomerDetailsState(
          type: CustomerDetailsStateType.loading,
          customerInfo: state.customerInfo,
          accountInfo: state.accountInfo);
      await _authenticationService.logOutFromAccount();
      Get.offAll(LoginPage());
    } else if (event is UpdateClientDetails) {
      CustomerDetailsState(
          type: CustomerDetailsStateType.loading,
          customerInfo: state.customerInfo,
          accountInfo: state.accountInfo);
      await _customerManagementService.updateCustomerInfo(
          CustomerManagementRequest(firstName: event.firstName, lastName: event.lastName));
      final AccountInfoResponse accountInfoResponse = await _accountService.fetchAccountDetails();
      yield CustomerDetailsState(
          type: CustomerDetailsStateType.fetched,
          customerInfo: state.customerInfo,
          accountInfo: accountInfoResponse);
    }
  }
}
