part of 'client_details_management_bloc.dart';

class ClientDetailsManagementState extends Equatable {
  final CompanyCustomerResponse customerResponse;
  final ClientDetailsManagementStateType type;
  const ClientDetailsManagementState({this.customerResponse, this.type});

  // ClientDetailsManagementState copyWith({
  //   final CompanyCustomerResponse customerResponse,
  // }) {
  //   return ClientDetailsManagementState(
  //     customerResponse: customerResponse ?? this.customerResponse,
  //   );
  // }

  @override
  List<Object> get props => [customerResponse, type];
}

enum ClientDetailsManagementStateType { initial, clientUpdated, loading, error }
