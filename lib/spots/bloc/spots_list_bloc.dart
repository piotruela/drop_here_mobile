import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:drop_here_mobile/spots/services/spot_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'spots_list_event.dart';
part 'spots_list_state.dart';

class SpotsListBloc extends Bloc<SpotsListEvent, SpotsListState> {
  final SpotManagementService spotManagementService = Get.find<SpotManagementService>();
  SpotsListBloc() : super(SpotsListInitial());

  @override
  Stream<SpotsListState> mapEventToState(
    SpotsListEvent event,
  ) async* {
    if (event is FetchSpots) {
      List<SpotCompanyResponse> spots = await spotManagementService.fetchCompanySpots();
      yield SpotsFetched(spots: spots);
    }
  }
}
