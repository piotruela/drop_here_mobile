import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'company_management_event.dart';
part 'company_management_state.dart';

class CompanyManagementBloc extends Bloc<CompanyManagementEvent, CompanyManagementState> {
  CompanyManagementBloc() : super(CompanyManagementInitial());

  final CompanyManagementService companyManagementService = Get.find<CompanyManagementService>();

  @override
  Stream<CompanyManagementState> mapEventToState(
    CompanyManagementEvent event,
  ) async* {
    yield CompanyDetailsFetchingInProgress();
    if (event is FetchCompanyDetails) {
      try {
        final Image image = await companyManagementService.getCompanyPhoto();
        final Company company = await companyManagementService.getCompanyInfo();
        yield CompanyDetailsFetched(company, image);
      } catch (NetworkImageLoadException) {
        yield CompanyManagementFetchingError();
      }
    }
  }
}
