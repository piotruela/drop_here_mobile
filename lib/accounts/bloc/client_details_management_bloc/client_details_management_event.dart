part of 'client_details_management_bloc.dart';

abstract class ClientDetailsManagementEvent extends Equatable {
  const ClientDetailsManagementEvent();
}

class ClientDetailsInitial extends ClientDetailsManagementEvent {
  final CompanyCustomerResponse customerResponse;

  ClientDetailsInitial(this.customerResponse);
  @override
  List<Object> get props => [customerResponse];
}

class FetchClientDetails extends ClientDetailsManagementEvent {
  final CompanyCustomerResponse customerResponse;

  FetchClientDetails(this.customerResponse);
  @override
  List<Object> get props => [customerResponse];
}

class BlockUser extends ClientDetailsManagementEvent {
  const BlockUser();
  @override
  List<Object> get props => [];
}
