part of 'spot_details_bloc.dart';

abstract class SpotDetailsState extends Equatable {
  const SpotDetailsState();
}

class SpotDetailsInitial extends SpotDetailsState {
  const SpotDetailsInitial();
  @override
  List<Object> get props => [];
}

class SpotDetailsLoading extends SpotDetailsState {
  const SpotDetailsLoading();

  @override
  List<Object> get props => [];
}

class SpotDetailsFetched extends SpotDetailsState {
  final SpotCompanyResponse spot;
  const SpotDetailsFetched(this.spot);

  @override
  List<Object> get props => [spot];
}

class SpotDetailsFetchingError extends SpotDetailsState {
  final String error;
  const SpotDetailsFetchingError(this.error);

  @override
  List<Object> get props => [error];
}
