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

class CompanyDetailsFetchingInProgress extends CompanyManagementState {
  const CompanyDetailsFetchingInProgress();

  @override
  List<Object> get props => [];
}

class CompanyDetailsFetched extends CompanyManagementState {
  final Company company;
  final Image image;
  const CompanyDetailsFetched(this.company, this.image);

  @override
  List<Object> get props => [company, image];
}

class CompanyManagementFetchingError extends CompanyManagementState {
  const CompanyManagementFetchingError();

  @override
  List<Object> get props => [];
}
