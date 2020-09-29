import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/company/company_register_details_api.dart';
import 'package:drop_here_mobile/accounts/services/registration_service.dart';
import 'package:equatable/equatable.dart';

part 'company_register_details_event.dart';
part 'company_register_details_state.dart';

class CompanyRegisterDetailsBloc
    extends Bloc<CompanyRegisterFormEvent, CompanyRegistrationDetailsFormState> {
  final RegistrationService registrationService = RegistrationService();
  CompanyRegisterDetailsBloc()
      : super(CompanyRegistrationDetailsFormState(form: CompanyDetails(visibility: "VISIBLE")));

  @override
  Stream<CompanyRegistrationDetailsFormState> mapEventToState(
    CompanyRegisterFormEvent event,
  ) async* {
    if (event is FormChanged) {
      CompanyDetails form = event.form;
      yield state.copyWith(form: form);
    } else if (event is FormSubmitted) {
      registrationService.updateCompanyDetails(event.form);
    }
  }
}
