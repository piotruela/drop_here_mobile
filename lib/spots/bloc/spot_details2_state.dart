part of 'spot_details2_bloc.dart';

class SpotDetailsState extends Equatable {
  final SpotDetailsStateType type;
  final SpotDetailedCustomerResponse spot;

  SpotDetailsState({this.type, this.spot});

  @override
  List<Object> get props => [type, spot];
}

enum SpotDetailsStateType { loading, success, failure, panel_closed }
