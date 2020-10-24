import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/accounts/ui/pages/management_page.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'edit_company_details_event.dart';
part 'edit_company_details_state.dart';

class EditCompanyDetailsBloc extends Bloc<EditCompanyDetailsEvent, EditCompanyDetailsState> {
  final CompanyManagementService companyManagementService = Get.find<CompanyManagementService>();
  EditCompanyDetailsBloc(Company company)
      : super(EditCompanyDetailsState(
            request: CompanyManagementRequest(
                companyName: company.name,
                countryName: company.country,
                visibility: describeEnum(company.visibilityStatus))));

  @override
  Stream<EditCompanyDetailsState> mapEventToState(
    EditCompanyDetailsEvent event,
  ) async* {
    if (event is FormChanged) {
      CompanyManagementRequest request = event.request;
      yield state.copyWith(request: request);
    } else if (event is PhotoChanged) {
      yield state.copyWith(companyImage: event.companyImage);
    } else if (event is FormSubmitted) {
      await companyManagementService.updateCompanyDetails(event.request);
      if (event.companyImage != null) {
        await companyManagementService.uploadCompanyPhoto(event.companyImage);
      }
      Get.to(
        ManagementPage(initialIndex: 2),
      );
    }
  }
}
