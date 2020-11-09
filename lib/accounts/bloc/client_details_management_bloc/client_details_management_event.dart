part of 'client_details_management_bloc.dart';

abstract class ClientDetailsManagementEvent extends Equatable {
  const ClientDetailsManagementEvent();
}

class ClientDetailsInitial extends ClientDetailsManagementEvent {
  final CompanyCustomerResponse customerResponse;

  ClientDetailsInitial(this.customerResponse);
  @override
  List<Object> get props => [];
}

class FetchClientDetails extends ClientDetailsManagementEvent {
  final CompanyCustomerResponse customerResponse;

  FetchClientDetails(this.customerResponse);
  @override
  List<Object> get props => [];
}
