part of 'company_management_bloc.dart';

@immutable
abstract class CompanyManagementState extends Equatable {
  const CompanyManagementState();
}

class CompanyManagementInitial extends CompanyManagementState {
  const CompanyManagementInitial();
  @override
  List<Object> get props => [];
}

class CompanyManagementLoading extends CompanyManagementState {
  const CompanyManagementLoading();

  @override
  List<Object> get props => [];
}

class CompanyManagementFetched extends CompanyManagementState {
  final localCompany.Company company;
  const CompanyManagementFetched(this.company);

  @override
  List<Object> get props => [company];
}

class CompanyManagementFetchingError extends CompanyManagementState {
  final String error;
  const CompanyManagementFetchingError(this.error);

  @override
  List<Object> get props => [error];
}
