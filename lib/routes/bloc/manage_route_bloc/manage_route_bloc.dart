import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/products/model/api/page_api.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/products/services/product_management_service.dart';
import 'package:drop_here_mobile/routes/model/route_request_api.dart';
import 'package:drop_here_mobile/routes/services/route_management_service.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:drop_here_mobile/spots/services/spot_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'manage_route_event.dart';
part 'manage_route_state.dart';

class ManageRouteBloc extends Bloc<ManageRouteEvent, ManageRouteState> {
  final CompanyManagementService companyManagementService = Get.find<CompanyManagementService>();
  final ProductManagementService productManagementService = Get.find<ProductManagementService>();
  final SpotManagementService spotManagementService = Get.find<SpotManagementService>();
  final RouteManagementService routeManagementService = Get.find<RouteManagementService>();
  ManageRouteBloc() : super(ManageRouteState(type: ManageRouteStateType.loading, routeRequest: null));

  @override
  Stream<ManageRouteState> mapEventToState(
    ManageRouteEvent event,
  ) async* {
    if (event is InitializeForm) {
      yield ManageRouteState(type: ManageRouteStateType.loading, routeRequest: event.routeRequest);
      List<ProfileInfoResponse> profiles = await companyManagementService.fetchCompanySellers();
      final ProductsPage productsPage = await productManagementService.getCompanyProducts();
      final List<SpotCompanyResponse> spots = await spotManagementService.fetchCompanySpots();
      yield ManageRouteState(
          type: ManageRouteStateType.initial,
          routeRequest: event.routeRequest,
          sellerProfiles: profiles,
          products: productsPage.content + event.alreadyAddedProducts,
          spots: spots);
    } else if (event is FormChanged) {
      yield ManageRouteState(
          type: ManageRouteStateType.form_changed,
          routeRequest: event.routeRequest,
          sellerProfiles: state.sellerProfiles,
          products: state.products,
          spots: state.spots);
    } else if (event is AddDrop) {
      List<RouteDropRequest> drops = state.routeRequest.drops;
      drops.add(event.drop);
      yield ManageRouteState(
          type: ManageRouteStateType.form_changed,
          routeRequest: state.routeRequest.copyWith(drops: drops),
          sellerProfiles: state.sellerProfiles,
          products: state.products,
          spots: state.spots);
    } else if (event is RemoveDrop) {
      List<RouteDropRequest> drops = state.routeRequest.drops;
      drops.remove(event.drop);
      yield ManageRouteState(
          type: ManageRouteStateType.form_changed,
          routeRequest: state.routeRequest.copyWith(drops: drops),
          sellerProfiles: state.sellerProfiles,
          products: state.products,
          spots: state.spots);
    } else if (event is RemoveProduct) {
      List<RouteProductRequest> selectedProducts = state.routeRequest.products;
      selectedProducts.removeWhere((element) => element.productId == event.productId);
      yield ManageRouteState(
          type: ManageRouteStateType.form_changed,
          routeRequest: state.routeRequest.copyWith(products: selectedProducts),
          sellerProfiles: state.sellerProfiles,
          products: state.products,
          spots: state.spots);
    } else if (event is FormSubmitted) {
      yield ManageRouteState(
          type: ManageRouteStateType.loading,
          routeRequest: state.routeRequest,
          sellerProfiles: state.sellerProfiles,
          products: state.products,
          spots: state.spots);
      ResourceOperationResponse response;
      if (event?.routeId != null) {
        response = await routeManagementService.updateRoute(state.routeRequest, event.routeId);
      } else {
        response = await routeManagementService.createRoute(state.routeRequest);
      }
      if (response.operationStatus != OperationStatus.ERROR) {
        yield ManageRouteState(type: ManageRouteStateType.added_successfully);
      }
    }
  }
}
