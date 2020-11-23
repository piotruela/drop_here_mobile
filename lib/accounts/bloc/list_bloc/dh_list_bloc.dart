import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/company_customers_request.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/products/model/api/page_api.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/products/services/product_management_service.dart';
import 'package:drop_here_mobile/shipments/model/api/company_shipment_request.dart';
import 'package:drop_here_mobile/shipments/model/api/company_shipment_response.dart';
import 'package:drop_here_mobile/shipments/model/api/customer_shipment_request.dart';
import 'package:drop_here_mobile/shipments/service/company_shipment_service.dart';
import 'package:drop_here_mobile/shipments/service/customer_shipment_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'dh_list_event.dart';
part 'dh_list_state.dart';

class DhListBloc extends Bloc<DhListEvent, DhListState> {
  final CompanyManagementService companyManagementService = Get.find<CompanyManagementService>();
  final ProductManagementService productManagementService = Get.find<ProductManagementService>();
  final CompanyShipmentService companyShipmentService = Get.find<CompanyShipmentService>();
  final CustomerShipmentService customerShipmentService = Get.find<CustomerShipmentService>();

  DhListBloc() : super(DhListInitial());

  @override
  Stream<DhListState> mapEventToState(
    DhListEvent event,
  ) async* {
    yield ListLoading();
    if (event is FetchClients) {
      try {
        final Page clientsPage = await companyManagementService.getCompanyCustomers(CompanyCustomersRequest());
        yield ClientsFetched(clientsPage.content);
      } catch (e) {
        yield FetchingError(e);
      }
    } else if (event is FilterClients) {
      try {
        //TODO: Add fetching with filters
        /*final List<Client> clients =
            await companyManagementService.fetchClientsList(filter: event.filter);
        yield ClientsFetched(clients);*/
      } catch (e) {
        yield FetchingError(e);
      }
    } else if (event is SearchClients) {
      try {
        //TODO: Add fetching using search
        /*final List<Client> clients =
            await companyManagementService.fetchClientsList(searchText: event.searchText);
        yield ClientsFetched(clients);*/
      } catch (e) {
        yield FetchingError(e);
      }
    } else if (event is FetchSellers) {
      try {
        final List<ProfileInfoResponse> apiSellers = await companyManagementService.fetchCompanySellers();
        yield SellersFetched(apiSellers);
      } catch (e) {
        yield FetchingError(e);
      }
    } else if (event is FetchProducts) {
      final ProductsPage products = await productManagementService.getCompanyProducts();
      yield ProductsFetched(products: products.content);
    } else if (event is DeleteProduct) {
      await productManagementService.deleteProduct(event.productId.toString());
      final ProductsPage products = await productManagementService.getCompanyProducts();
      yield ProductsFetched(products: products.content);
    } else if (event is FetchShipments) {
      final ShipmentsPage shipmentsPage = await companyShipmentService.getCompanyShipments(CompanyShipmentRequest());
      yield ShipmentsFetched(shipments: shipmentsPage.content);
    } else if (event is FetchCustomerShipments) {
      final ShipmentsPage shipmentsPage = await customerShipmentService.getShipments(CustomerShipmentRequest());
      yield ShipmentsFetched(shipments: shipmentsPage.content);
    }
  }
}
