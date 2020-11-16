part of 'customer_details_bloc.dart';

class CustomerDetailsState extends Equatable {
  final CustomerDetailsStateType type;
  final CustomerInfoResponse customerInfo;
  final AccountInfoResponse accountInfo;

  CustomerDetailsState({this.type, this.customerInfo, this.accountInfo});

  @override
  List<Object> get props => [type, customerInfo, accountInfo];
}

enum CustomerDetailsStateType { loading, error, fetched }
