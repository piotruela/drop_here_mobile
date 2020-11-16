part of 'countries_bloc.dart';

abstract class CountriesState extends Equatable {
  const CountriesState();
}

class CountriesInitial extends CountriesState {
  @override
  List<Object> get props => [];
}

class CountriesFetchingLoading extends CountriesState {
  @override
  List<Object> get props => [];
}

class CountriesFetchingSuccess extends CountriesState {
  final List<Country> countries;

  CountriesFetchingSuccess({this.countries});

  @override
  List<Object> get props => [countries];
}

class CountriesFetchingFailure extends CountriesState {
  @override
  List<Object> get props => [];
}
