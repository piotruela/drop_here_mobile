part of 'customer_spots_bloc.dart';

class CustomerSpotsState extends Equatable {
  final List<SpotBaseCustomerResponse> spots;
  final CustomerSpotsStateType type;

  CustomerSpotsState({this.spots, this.type});

  @override
  List<Object> get props => [spots, type];
}

enum CustomerSpotsStateType { loading, success, failure, join_request_sent }
