part of 'company_register_details_bloc.dart';

class CompanyRegistrationDetailsFormState extends Equatable {
  final CompanyDetails form;

  CompanyRegistrationDetailsFormState({this.form});

  CompanyRegistrationDetailsFormState copyWith({CompanyDetails form}) {
    return CompanyRegistrationDetailsFormState(form: form ?? this.form);
  }

  @override
  List<Object> get props => [form];
}
