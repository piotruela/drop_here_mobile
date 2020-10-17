import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/company_customers_request.dart';
import 'package:drop_here_mobile/accounts/model/api/page_api.dart';
import 'package:drop_here_mobile/accounts/model/client.dart';
import 'package:drop_here_mobile/accounts/model/product_with_photo.dart';
import 'package:drop_here_mobile/accounts/model/seller.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/accounts/services/product_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show Image;
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'dh_list_event.dart';
part 'dh_list_state.dart';

class DhListBloc extends Bloc<DhListEvent, DhListState> {
  final CompanyManagementService companyManagementService = Get.find<CompanyManagementService>();
  final ProductManagementService productManagementService = Get.find<ProductManagementService>();

  DhListBloc() : super(DhListInitial());

  @override
  Stream<DhListState> mapEventToState(
    DhListEvent event,
  ) async* {
    yield ListLoading();
    if (event is FetchClients) {
      try {
        final Page clientsPage = await companyManagementService
            .getCompanyCustomers(CompanyCustomersRequest()..blocked = false);
        print(clientsPage.size);
        yield ClientsFetched(
            clientsPage.content.map((client) => client.convertFromApiModel()).toList());
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
        final List<ProfileInfoResponse> apiSellers =
            await companyManagementService.fetchCompanySellers();
        yield SellersFetched(apiSellers.map((seller) => seller.convertFromApiModel()).toList());
      } catch (e) {
        yield FetchingError(e);
      }
    } else if (event is FetchProducts) {
      try {
        final ProductsPage products = await productManagementService.getCompanyProducts();
        final List<ProductWithPhoto> productsWithPhoto = [];
        for (var product in products.content) {
          Image photo = await productManagementService.getProductPhoto(product.id.toString());
          ProductWithPhoto productWithPhoto = ProductWithPhoto(
            category: product.category,
            productCustomizationWrappers: product.productCustomizationWrappers,
            id: product.id,
            name: product.name,
            description: product.description,
            price: product.price,
            unit: product.unit,
            unitFraction: product.unitFraction,
            photo: photo,
          );
          productsWithPhoto.add(productWithPhoto);
        }
        yield ProductsFetched(productsWithPhoto);
      } catch (e) {
        yield FetchingError(e);
      }
    }
  }
}
