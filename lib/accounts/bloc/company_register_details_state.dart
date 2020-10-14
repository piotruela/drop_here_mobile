part of 'company_register_details_bloc.dart';

class CompanyRegistrationDetailsFormState extends Equatable {
  final CompanyManagementRequest form;
  final List<Country> countries;

  CompanyRegistrationDetailsFormState({this.form, this.countries});

  CompanyRegistrationDetailsFormState copyWith(
      {CompanyManagementRequest form, List<Country> countries}) {
    return CompanyRegistrationDetailsFormState(
        form: form ?? this.form, countries: countries ?? this.countries);
  }

  @override
  List<Object> get props => [form, countries];
}

class LoadingState extends CompanyRegistrationDetailsFormState {}

class ErrorState extends CompanyRegistrationDetailsFormState {}

class SuccessState extends CompanyRegistrationDetailsFormState {}
