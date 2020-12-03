part of 'customer_details_bloc.dart';

class CustomerDetailsState extends Equatable {
  final CustomerDetailsStateType type;
  final CustomerInfoResponse customerInfo;
  final AccountInfoResponse accountInfo;
  final String photo;

  CustomerDetailsState({this.type, this.customerInfo, this.accountInfo, this.photo});

  @override
  List<Object> get props => [type, customerInfo, accountInfo, photo];
}

enum CustomerDetailsStateType { loading, error, fetched }
