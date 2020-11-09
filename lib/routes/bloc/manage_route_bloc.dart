import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/products/model/api/page_api.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/products/services/product_management_service.dart';
import 'package:drop_here_mobile/routes/model/route_request_api.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'manage_route_event.dart';
part 'manage_route_state.dart';

class ManageRouteBloc extends Bloc<ManageRouteEvent, ManageRouteState> {
  final CompanyManagementService companyManagementService = Get.find<CompanyManagementService>();
  final ProductManagementService productManagementService = Get.find<ProductManagementService>();
  ManageRouteBloc() : super(ManageRouteState(type: ManageRouteStateType.loading, routeRequest: null));

  @override
  Stream<ManageRouteState> mapEventToState(
    ManageRouteEvent event,
  ) async* {
    if (event is InitializeForm) {
      yield ManageRouteState(type: ManageRouteStateType.loading, routeRequest: event.routeRequest);
      List<ProfileInfoResponse> profiles = await companyManagementService.fetchCompanySellers();
      final ProductsPage productsPage = await productManagementService.getCompanyProducts();
      final List<ProductResponse> products = productsPage.content;
      yield ManageRouteState(
          type: ManageRouteStateType.initial, routeRequest: event.routeRequest, sellerProfiles: profiles);
    } else if (event is FormChanged2) {
      yield ManageRouteState(
          type: ManageRouteStateType.form_changed,
          routeRequest: event.routeRequest,
          sellerProfiles: state.sellerProfiles);
    } else if (event is RemoveSeller) {
      yield ManageRouteState(
          type: ManageRouteStateType.form_changed,
          routeRequest: state.routeRequest.copyWith(sellerNull: true),
          sellerProfiles: state.sellerProfiles);
    }
  }
}
