part of 'company_register_details_bloc.dart';

abstract class CompanyRegisterFormEvent extends Equatable {
  const CompanyRegisterFormEvent();

  @override
  List<Object> get props => [];
}

class FormChanged extends CompanyRegisterFormEvent {
  final CompanyDetails form;

  FormChanged({this.form});

  @override
  List<Object> get props => [form];
}

class FormSubmitted extends CompanyRegisterFormEvent {
  final bool isValid;
  final CompanyDetails form;

  FormSubmitted({this.isValid, this.form});

  @override
  List<Object> get props => [form, isValid];
}
