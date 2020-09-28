import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/company/company_register_details_api.dart';
import 'package:equatable/equatable.dart';

part 'company_register_details_event.dart';
part 'company_register_details_state.dart';

class CompanyRegisterDetailsBloc
    extends Bloc<CompanyRegisterFormEvent, CompanyRegistrationDetailsFormState> {
  CompanyRegisterDetailsBloc() : super(CompanyRegistrationDetailsFormState(form: CompanyDetails()));

  @override
  Stream<CompanyRegistrationDetailsFormState> mapEventToState(
    CompanyRegisterFormEvent event,
  ) async* {
    if (event is FormChanged) {
      CompanyDetails form = event.form;
      yield state.copyWith(form: form);
    } else if (event is FormSubmitted) {
      print(event.form.companyName);
      print(event.form.countryName);
      print(event.form.visibility.toString());
    }
  }
}
