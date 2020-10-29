part of 'customer_map_bloc.dart';

class CustomerMapState extends Equatable {
  final List<SpotBaseCustomerResponse> spots;
  final CustomerMapStateType type;
  final SpotDetailedCustomerResponse spot;

  CustomerMapState({this.spots, this.type, this.spot});

  @override
  List<Object> get props => [spots, type, spot];
}

enum CustomerMapStateType { loading, success, failure }
