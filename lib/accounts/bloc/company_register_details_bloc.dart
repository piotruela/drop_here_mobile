import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/company/company_register_details_api.dart';
import 'package:drop_here_mobile/accounts/model/country.dart';
import 'package:drop_here_mobile/accounts/services/implementation/dh_countries_service.dart';
import 'package:drop_here_mobile/accounts/services/registration_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'company_register_details_event.dart';
part 'company_register_details_state.dart';

class CompanyRegisterDetailsBloc
    extends Bloc<CompanyRegisterFormEvent, CompanyRegistrationDetailsFormState> {
  final RegistrationService registrationService = RegistrationService();
  CompanyRegisterDetailsBloc() : super(CompanyRegistrationDetailsFormState());

  @override
  Stream<CompanyRegistrationDetailsFormState> mapEventToState(
    CompanyRegisterFormEvent event,
  ) async* {
    if (event is FormInitialized) {
      yield LoadingState();
      final DHCountriesService dhCountriesService = Get.find<DHCountriesService>();
      List<Country> countries = await dhCountriesService.getCountries();
      yield state.copyWith(form: CompanyDetails(visibility: "VISIBLE"), countries: countries);
    }
    if (event is FormChanged) {
      CompanyDetails form = event.form;
      yield state.copyWith(form: form);
    } else if (event is FormSubmitted) {
      registrationService.updateCompanyDetails(event.form);
    }
  }
}
