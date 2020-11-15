part of 'company_management_bloc.dart';

@immutable
abstract class CompanyManagementEvent extends Equatable {
  const CompanyManagementEvent();
}

class FetchCompanyDetails extends CompanyManagementEvent {
  const FetchCompanyDetails();

  @override
  List<Object> get props => [];
}
