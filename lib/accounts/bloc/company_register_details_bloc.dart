import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/country_api.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/accounts/services/countries_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'company_register_details_event.dart';
part 'company_register_details_state.dart';

class CompanyRegisterDetailsBloc
    extends Bloc<CompanyRegisterFormEvent, CompanyRegistrationDetailsFormState> {
  final CompanyManagementService companyManagementService = CompanyManagementService();
  CompanyRegisterDetailsBloc() : super(CompanyRegistrationDetailsFormState());

  @override
  Stream<CompanyRegistrationDetailsFormState> mapEventToState(
    CompanyRegisterFormEvent event,
  ) async* {
    if (event is FormInitialized) {
      yield LoadingState();
      final CountriesService dhCountriesService = Get.find<CountriesService>();
      List<Country> countries = await dhCountriesService.getCountries();
      yield state.copyWith(
          form: CompanyManagementRequest(visibility: "VISIBLE"), countries: countries);
    }
    if (event is FormChanged) {
      CompanyManagementRequest form = event.form;
      yield state.copyWith(form: form);
    } else if (event is FormSubmitted) {
      yield LoadingState();
      try {
        companyManagementService.updateCompanyDetails(event.form);
        yield SuccessState();
      } on Exception {
        yield ErrorState();
      }
    }
  }
}
