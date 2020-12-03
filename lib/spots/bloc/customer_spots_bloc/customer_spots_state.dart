part of 'customer_spots_bloc.dart';

class CustomerSpotsState extends Equatable {
  final List<SpotBaseCustomerResponse> spots;
  final CustomerSpotsStateType type;
  final SpotDetailedCustomerResponse spotDetails;

  CustomerSpotsState({this.spots, this.type, this.spotDetails});

  @override
  List<Object> get props => [spots, type, spotDetails];
}

enum CustomerSpotsStateType { loading, success, failure, spot_managed, spot_fetched }
