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
      //TODO add parameters to request
      Page page = await companyManagementService.getCompanyCustomers(CompanyCustomersRequest());
      //page.content.
      yield ClientDetailsManagementState(
          customerResponse: event.customerResponse,
          type: ClientDetailsManagementStateType.clientUpdated);
    } else if (event is BlockUser) {
      //TODO implement
      yield ClientDetailsManagementState(type: ClientDetailsManagementStateType.clientUpdated);
    }
  }
}
