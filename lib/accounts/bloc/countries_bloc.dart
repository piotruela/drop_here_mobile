import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/country_api.dart';
import 'package:drop_here_mobile/accounts/services/countries_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'countries_event.dart';
part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final CountriesService dhCountriesService = Get.find<CountriesService>();
  CountriesBloc() : super(CountriesInitial());

  @override
  Stream<CountriesState> mapEventToState(
    CountriesEvent event,
  ) async* {
    if (event is FetchCountries) {
      yield CountriesFetchingLoading();
      try {
        List<Country> countries = await dhCountriesService.getCountries();
        yield CountriesFetchingSuccess(countries: countries);
      } on Exception {
        yield CountriesFetchingFailure();
      }
    }
  }
}
