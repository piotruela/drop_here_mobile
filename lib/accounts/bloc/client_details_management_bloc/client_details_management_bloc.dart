import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/company_customers_request.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/products/model/api/page_api.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'client_details_management_event.dart';
part 'client_details_management_state.dart';

class ClientDetailsManagementBloc
    extends Bloc<ClientDetailsManagementEvent, ClientDetailsManagementState> {
  ClientDetailsManagementBloc() : super(ClientDetailsManagementState());
  final CompanyManagementService companyManagementService = Get.find<CompanyManagementService>();

  @override
  Stream<ClientDetailsManagementState> mapEventToState(
    ClientDetailsManagementEvent event,
  ) async* {
    if (event is ClientDetailsInitial) {
      yield ClientDetailsManagementState(
          customerResponse: event.customerResponse, type: ClientDetailsManagementStateType.initial);
    } else if (event is FetchClientDetails) {
      yield ClientDetailsManagementState(type: ClientDetailsManagementStateType.loading);
      //TODO add parameters to request
      Page page = await companyManagementService.getCompanyCustomers(CompanyCustomersRequest());
      yield ClientDetailsManagementState(
          customerResponse:
              page.content.firstWhere((customer) => customer.customerId == event.customerId),
          type: ClientDetailsManagementStateType.clientUpdated);
    } else if (event is BlockUser) {
      CompanyCustomerManagementRequest request = CompanyCustomerManagementRequest(block: true);
      ResourceOperationResponse response =
          await companyManagementService.updateCustomer(request, event.userId.toString());
      Page page = await companyManagementService.getCompanyCustomers(CompanyCustomersRequest());
      yield ClientDetailsManagementState(
          customerResponse:
              page.content.firstWhere((customer) => customer.customerId == event.userId),
          type: ClientDetailsManagementStateType.clientUpdated);
    }
  }
}
