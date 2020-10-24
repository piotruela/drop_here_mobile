part of 'edit_company_details_bloc.dart';

abstract class EditCompanyDetailsEvent extends Equatable {
  const EditCompanyDetailsEvent();
}

class FormChanged extends EditCompanyDetailsEvent {
  final CompanyManagementRequest request;

  FormChanged({this.request});

  @override
  List<Object> get props => [request];
}

class PhotoChanged extends EditCompanyDetailsEvent {
  final Future<File> companyImage;

  PhotoChanged({this.companyImage});

  @override
  List<Object> get props => [companyImage];
}

class FormSubmitted extends EditCompanyDetailsEvent {
  final CompanyManagementRequest request;
  final Future<File> companyImage;

  FormSubmitted({this.request, this.companyImage});

  @override
  List<Object> get props => [request, companyImage];
}
