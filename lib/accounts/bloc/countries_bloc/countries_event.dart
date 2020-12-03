part of 'countries_bloc.dart';

abstract class CountriesEvent extends Equatable {
  const CountriesEvent();
}

class FetchCountries extends CountriesEvent {
  @override
  List<Object> get props => [];
}
