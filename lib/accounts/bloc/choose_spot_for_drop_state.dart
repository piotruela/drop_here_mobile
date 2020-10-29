part of 'choose_spot_for_drop_bloc.dart';

class ChooseSpotForDropState extends Equatable {
  final List<SpotCompanyResponse> spots;
  final int radioValue;

  const ChooseSpotForDropState({this.spots, this.radioValue});

  ChooseSpotForDropState copyWith({spots, radioValue}) {
    return ChooseSpotForDropState(
        spots: spots ?? this.spots, radioValue: radioValue ?? this.radioValue);
  }

  @override
  List<Object> get props => [spots, radioValue];
}

class ChooseSpotForDropInitial extends ChooseSpotForDropState {}

class SpotsForDropFetched extends ChooseSpotForDropState {
  final List<SpotCompanyResponse> spots;
  final int radioValue;

  const SpotsForDropFetched({this.spots, this.radioValue});

  SpotsForDropFetched copyWith({spots, radioValue}) {
    return SpotsForDropFetched(
        spots: spots ?? this.spots, radioValue: radioValue ?? this.radioValue);
  }

  @override
  List<Object> get props => [spots, radioValue];
}

class ChooseSpotForDropError extends ChooseSpotForDropState {
  final String error;
  const ChooseSpotForDropError(this.error);
  @override
  List<Object> get props => [error];
}
