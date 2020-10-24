import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:drop_here_mobile/spots/services/spot_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'choose_spot_for_drop_event.dart';
part 'choose_spot_for_drop_state.dart';

class ChooseSpotForDropBloc extends Bloc<ChooseSpotForDropEvent, ChooseSpotForDropState> {
  ChooseSpotForDropBloc() : super(ChooseSpotForDropInitial());
  final SpotManagementService spotManagementService = Get.find<SpotManagementService>();
  @override
  Stream<ChooseSpotForDropState> mapEventToState(
    ChooseSpotForDropEvent event,
  ) async* {
    yield ChooseSpotForDropInitial();
    if (event is FetchSpotsForDrop) {
      try {
        final List<SpotCompanyResponse> spots = await spotManagementService.fetchCompanySpots();
        yield SpotsForDropFetched(spots: spots, radioValue: -1);
      } catch (e) {
        yield ChooseSpotForDropError(e);
      }
    } else if (event is ChangeGroupValue) {
      yield SpotsForDropFetched(spots: event.spots, radioValue: event.groupValue);
    }
  }
}
