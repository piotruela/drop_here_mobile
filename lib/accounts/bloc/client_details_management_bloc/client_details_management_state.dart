part of 'client_details_management_bloc.dart';

class ClientDetailsManagementState extends Equatable {
  final CompanyCustomerResponse customerResponse;
  const ClientDetailsManagementState({this.customerResponse});

  // ClientDetailsManagementState copyWith({
  //   final CompanyCustomerResponse customerResponse,
  // }) {
  //   return ClientDetailsManagementState(
  //     customerResponse: customerResponse ?? this.customerResponse,
  //   );
  // }

  @override
  List<Object> get props => [customerResponse];
}

enum ClientDetailsManagementStateType { initial, clientUpdated, loading, error }
