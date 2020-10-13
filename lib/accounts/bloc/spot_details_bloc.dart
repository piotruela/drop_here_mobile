import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/services/spot_service.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'spot_details_event.dart';
part 'spot_details_state.dart';

class SpotDetailsBloc extends Bloc<SpotDetailsEvent, SpotDetailsState> {
  SpotDetailsBloc() : super(SpotDetailsInitial());

  final SpotService spotService = Get.find<SpotService>();

  @override
  Stream<SpotDetailsState> mapEventToState(
    SpotDetailsEvent event,
  ) async* {
    yield SpotDetailsLoading();
    if (event is FetchSpotDetails) {
      try {
        final SpotCompanyResponse spot = await spotService.fetchSpotDetails();
        yield SpotDetailsFetched(spot);
      } catch (e) {
        yield SpotDetailsFetchingError(e.toString());
      }
    }
  }
}
