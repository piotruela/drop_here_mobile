part of 'company_register_details_bloc.dart';

class CompanyRegistrationDetailsFormState extends Equatable {
  final CompanyDetails form;
  final List<Country> countries;

  CompanyRegistrationDetailsFormState({this.form, this.countries});

  CompanyRegistrationDetailsFormState copyWith({CompanyDetails form, List<Country> countries}) {
    return CompanyRegistrationDetailsFormState(
        form: form ?? this.form, countries: countries ?? this.countries);
  }

  @override
  List<Object> get props => [form];
}

class LoadingState extends CompanyRegistrationDetailsFormState {}
