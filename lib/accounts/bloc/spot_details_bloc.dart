import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:equatable/equatable.dart';

part 'spot_details_event.dart';
part 'spot_details_state.dart';

class SpotDetailsBloc extends Bloc<SpotDetailsEvent, SpotDetailsState> {
  SpotDetailsBloc() : super(SpotDetailsInitial());

  @override
  Stream<SpotDetailsState> mapEventToState(
    SpotDetailsEvent event,
  ) async* {
    yield SpotDetailsLoading();
    if (event is FetchSpotDetails) {
      try {
        //TODO change service method when implemented in api
        //final SpotCompanyResponse spot = await SpotManagementService.fetchSpotDetails("RyneczoKygZWqfLg6");
        //yield SpotDetailsFetched(spot);
      } catch (e) {
        yield SpotDetailsFetchingError(e.toString());
      }
    }
  }
}
