part of 'company_spots_bloc.dart';

class CompanySpotsState extends Equatable {
  final List<SpotCompanyResponse> spots;
  final CompanySpotsStateType type;
  final SpotCompanyResponse spot;
  final SpotMembershipPage members;

  CompanySpotsState({this.spots, this.type, this.spot, this.members});

  @override
  List<Object> get props => [spots, type, spot, members];
}

enum CompanySpotsStateType { loading, success, failure, spot_details}
