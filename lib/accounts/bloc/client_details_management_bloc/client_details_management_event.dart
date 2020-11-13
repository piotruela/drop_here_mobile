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
  final int customerId;
  FetchClientDetails(this.customerId);
  @override
  List<Object> get props => [customerId];
}

class BlockUser extends ClientDetailsManagementEvent {
  final int userId;
  final bool block;
  const BlockUser(this.userId, this.block);
  @override
  List<Object> get props => [userId, block];
}

class ToggleSpotMembershipStatus extends ClientDetailsManagementEvent {
  final bool toggleToActive;
  final String spotUid;
  const ToggleSpotMembershipStatus(this.toggleToActive, this.spotUid);
  @override
  List<Object> get props => [toggleToActive, spotUid];
}
